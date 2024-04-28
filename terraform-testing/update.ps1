#Requires -Version 5.0
#Requires -Modules AU
[cmdletbinding()]
param (
  [switch]$Force
)

Set-StrictMode -Version Latest
$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Stop'
trap {
  Write-Host "ERROR: $_"
    ($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$', 'ERROR: $1' | Write-Host
    ($_.Exception.ToString() -split '\r?\n') -replace '^(.*)$', 'ERROR EXCEPTION: $1' | Write-Host
  throw
}

$releases_url = "https://releases.hashicorp.com/terraform"
$releases_index_url = "$releases_url/index.json"
$releaseNotesTemplate = @'

{0}## Previous Releases
For more information on previous releases, check out the changelog on [GitHub]({1}).
'@

function Get-TerraformBuild($builds, $os, $arch) {
  foreach ($build in $builds) {
    if (($build.os -eq $os) -and ($build.arch -eq $arch)) {
      return $build
    }
  }
  throw "Terraform build for os = $os and arch = $arch not found"
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

function GetStreams() {
  param($terraform_releases)
  $terraform_releases = Invoke-RestMethod $releases_index_url

  $all_versions = @{ }
  foreach ($release in $terraform_releases.versions.PSObject.Properties) {
    # Only consider releases that are 1.0.0 or later
    $version = Get-Version $release.Name
    if ($version.Version.Major -eq 0) {
      continue
    }

    $all_versions[$release.Name] = $release.Value
  }

  # find latest version of each supported Terraform version
  $latest_versions = @{ }
  $all_versions.GetEnumerator() | ForEach-Object {
    $version = Get-Version $_.Name
    if ($latest_versions.ContainsKey($version.Version.Minor)) {
      $known_latest_version = Get-Version $latest_versions[$version.Version.Minor]
    }
    else {
      $known_latest_version = Get-Version '0.0.0'
    }
    if ($version -gt $known_latest_version) {
      $latest_versions[$version.Version.Minor] = $_.Name
    }
  }

  $streams = @{ }

  $latest_versions.GetEnumerator() | ForEach-Object {
    $latest_version = $_.Value
    $version = Get-Version $latest_version
    $major_version = $version.Version.Major
    $minor_version = $version.Version.Minor
    $versionTwoPart = "$major_version.$minor_version"

    $version_details = $all_versions[$latest_version]

    $shasums = Get-Shasums "$($releases_url)/$($latest_version)/$($version_details.shasums)"
    Write-Verbose (ConvertTo-Json $shasums)
    $build32 = Get-TerraformBuild $version_details.builds 'windows' '386'
    Write-Verbose (ConvertTo-Json $build32)
    $build64 = Get-TerraformBuild $version_details.builds 'windows' 'amd64'
    Write-Verbose (ConvertTo-Json $build64)

    $streams[$versionTwoPart] = @{
      Version      = $latest_version
      URL32        = $build32.url
      URL64        = $build64.url
      Checksum32   = $shasums[$build32.filename]
      Checksum64   = $shasums[$build64.filename]
      ChangelogUrl = "https://github.com/hashicorp/terraform/blob/v$($latest_version)/CHANGELOG.md"
    }
  }

  Write-Host $streams.Count 'streams collected'
  $streams
}

function GetReleasesStreams {
  $terraform_releases = Invoke-RestMethod $releases_index_url

  GetStreams $terraform_releases
}

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

function global:au_GetLatest {
  @{ Streams = GetReleasesStreams }
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

function global:au_AfterUpdate {
  Write-Verbose (ConvertTo-Json $Latest)
  # Get the latest changes and set as <releaseNotes /> in our nuspec
  # Note: Cannot use au_SearchReplace for the releaseNotes because they are multi-lined
  $releaseNotes = Get-ReleaseNotes $Latest.Version $Latest.ChangelogUrl
  Write-Verbose $releaseNotes
  $nuspec = Join-Path $PSScriptRoot "$($Latest.PackageName).nuspec" -Resolve
  Set-ReleaseNotes $nuspec $releaseNotes
}

update -ChecksumFor none
Update-Package -NoReadme -ChecksumFor none -Force:$Force
