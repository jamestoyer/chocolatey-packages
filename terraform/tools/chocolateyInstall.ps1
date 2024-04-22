$ErrorActionPreference = 'Stop'

# DO NOT CHANGE THESE MANUALLY. USE update.ps1
$url = 'https://releases.hashicorp.com/terraform/1.8.1/terraform_1.8.1_windows_386.zip'
$url64 = 'https://releases.hashicorp.com/terraform/1.8.1/terraform_1.8.1_windows_amd64.zip'
$checksum = '86ba7a5d8b9c143b40cc3739ed5cee9a8d935ca4864f08887e46888fc7f3317a'
$checksum64 = '390312f89f37a3bb77d354d4d844564edb9e1a5f9fecca61686611108779bc99'

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
