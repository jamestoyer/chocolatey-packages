$ErrorActionPreference = 'Stop'

# DO NOT CHANGE THESE MANUALLY. USE update.ps1
$url = 'https://releases.hashicorp.com/terraform/1.16.1/terraform_1.16.1_windows_386.zip'
$url64 = 'https://releases.hashicorp.com/terraform/1.16.1/terraform_1.16.1_windows_amd64.zip'
$checksum = '82c3c8a0c31c60ac7f59c1f9dfc8f26a4720142c26b527c197544bac40e6eeb8'
$checksum64 = '5c6c6d8fedf56ce29c55f0c1fc91de3c259f42c2d220a28e827b5b60fd47bfa1'

$unzipLocation = Split-Path -Parent $MyInvocation.MyCommand.Definition

if ([System.IO.Directory]::Exists("$env:ChocolateyInstall\lib\terraform")) {
  if ([System.IO.Directory]::Exists("$env:ChocolateyInstall\lib\terraform\tools")) {
    # clean old plugins and ignore files
    Write-Host "Removing old terraform plugins"
    Remove-Item "$env:ChocolateyInstall\lib\terraform\tools\terraform-*.*"
  }
}
else {
  if ([System.IO.Directory]::Exists("$env:ALLUSERSPROFILE\chocolatey\lib\terraform")) {
    if ([System.IO.Directory]::Exists("$env:ALLUSERSPROFILE\chocolatey\lib\terraform\tools")) {
      # clean old plugins and ignore files
      Write-Host "Removing old terraform plugins"
      Remove-Item "$env:ALLUSERSPROFILE\chocolatey\lib\terraform\tools" -Include "terraform-*.*"
    }
  }
}

$packageParams = @{
  PackageName   = "terraform"
  UnzipLocation = $unzipLocation
  Url           = $url
  Url64         = $url64
  Checksum      = $checksum
  Checksum64    = $checksum64
  ChecksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageParams
