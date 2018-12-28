#Requires -Version 5.0
#Requires -Modules AU
[cmdletbinding()]
param (
  [switch]$Force
)

$ErrorActionPreference = 'Stop'

# See https://checkpoint.hashicorp.com/ and https://www.hashicorp.com/blog/hashicorp-fastly/#json-api
$checkpointUrl = "https://checkpoint-api.hashicorp.com/v1/check/terraform"

$releaseNotesTemplate = @'

{0}## Previous Releases
For more information on previous releases, check out the changelog on [GitHub]({1}).
'@

function Get-ReleaseNotes($version, $changelogUrl) {
  $rawChangelogUrl = "https://raw.githubusercontent.com/hashicorp/terraform/v$($version)/CHANGELOG.md"
  $fullChangelog = Invoke-RestMethod -Uri $rawChangelogUrl

  # get everyting from the first "##" up until the second "##"
  # note: [\s\S]* is used to select all characters including newline characters
  $changelogMatches = Select-String -InputObject $fullChangelog -Pattern '\A(##[\s\S]*?)##[\s\S]*\z' -AllMatches

  $latestChanges = $changelogMatches.Matches.Groups[1].Value
  if (-not $latestChanges) {
    throw "Could not get latest changes from $rawChangelogUrl"
  }

  return $releaseNotesTemplate -f $latestChanges, $changelogUrl
}

function Set-ReleaseNotes($nuspec, $releaseNotes) {
  [xml]$xml = Get-Content $nuspec
  $xml.package.metadata.releaseNotes = $releaseNotes
  $xml.Save($nuspec)
}

function global:au_AfterUpdate {
  Write-Verbose (ConvertTo-Json $Latest)
  # Get the latest changes and set as <releaseNotes /> in our nuspec
  # Note: Cannot use au_SearchReplace for the releaseNotes because they are multi-lined
  $releaseNotes = Get-ReleaseNotes $Latest.Version $Latest.ChangelogUrl
  Write-Verbose $releaseNotes
  $nuspec = Join-Path $PSScriptRoot "$($Latest.PackageName).nuspec" -Resolve
  Set-ReleaseNotes $nuspec $releaseNotes
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^[$]url\s*=\s*)'.*'"        = "`${1}'$($Latest.URL32)'"
      "(?i)(^[$]url64\s*=\s*)'.*'"      = "`${1}'$($Latest.URL64)'"
      "(?i)(^[$]checksum\s*=\s*)'.*'"   = "`${1}'$($Latest.Checksum32)'"
      "(?i)(^[$]checksum64\s*=\s*)'.*'" = "`${1}'$($Latest.Checksum64)'"
    }
  }
}

function Get-Shasums($url) {
  $response = Invoke-RestMethod -Uri $url
  Write-Verbose $response
  $shasums = @{}
  foreach ($line in ($response -split '\n')) {
    if ($line) {
      $sha, $file = $line -split '  '
      $shasums[$file] = $sha
    }
  }
  return $shasums
}

function Get-TerraformBuild($builds, $os, $arch) {
  foreach ($build in $builds) {
    if (($build.os -eq $os) -and ($build.arch -eq $arch)) {
      return $build
    }
  }
  throw "Terraform build for os = $os and arch = $arch not found"
}

function global:au_GetLatest {
  $terraformCheckpoint = Invoke-RestMethod -Uri $checkpointUrl
  Write-Verbose (ConvertTo-Json $terraformCheckpoint)
  $currentDownloadUrl = $terraformCheckpoint.current_download_url
  $terraformBuilds = Invoke-RestMethod -Uri "$($currentDownloadUrl)index.json"
  Write-Verbose (ConvertTo-Json $terraformBuilds)
  $shasums = Get-Shasums "$($currentDownloadUrl)$($terraformBuilds.shasums)"
  Write-Verbose (ConvertTo-Json $shasums)

  $build32 = Get-TerraformBuild $terraformBuilds.builds 'windows' '386'
  Write-Verbose (ConvertTo-Json $build32)
  $build64 = Get-TerraformBuild $terraformBuilds.builds 'windows' 'amd64'
  Write-Verbose (ConvertTo-Json $build64)

  return @{
    Version      = $terraformCheckpoint.current_version
    URL32        = $build32.url
    URL64        = $build64.url
    Checksum32   = $shasums[$build32.filename]
    Checksum64   = $shasums[$build64.filename]
    ChangelogUrl = $terraformCheckpoint.current_changelog_url
  }
}

# TLS 1.2 required by terraform's apis
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

Update-Package -NoCheckUrl -NoCheckChocoVersion -NoReadme -ChecksumFor none -Force:$Force
