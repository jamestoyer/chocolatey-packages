$ErrorActionPreference = 'Stop'

# DO NOT CHANGE THESE MANUALLY. USE update.ps1
$url = 'https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_windows_386.zip'
$url64 = 'https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_windows_amd64.zip'
$checksum = 'b82d1ffd89f16b75e54c56f1f7bc8c98331ebe802c8fe768926cd47890d70eb2'
$checksum64 = '1e020a208757f23da415b4fee74ae084984c2cfc20210b5c62513c6d9f0a174e'

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
