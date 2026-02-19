$ErrorActionPreference = 'Stop'

# DO NOT CHANGE THESE MANUALLY. USE update.ps1
$url = 'https://releases.hashicorp.com/terraform/1.15.0-alpha20260218/terraform_1.15.0-alpha20260218_windows_386.zip'
$url64 = 'https://releases.hashicorp.com/terraform/1.15.0-alpha20260218/terraform_1.15.0-alpha20260218_windows_amd64.zip'
$checksum = 'ceffb0920e3d65b910c767924992751d0c2cd663002fc3401d3aade64460e33e'
$checksum64 = 'f5bf2beade62c399004474276afac3ae7315e7020c63c28de0810d1d4e9f62a4'

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
