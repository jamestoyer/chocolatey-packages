$ErrorActionPreference = 'Stop'

# DO NOT CHANGE THESE MANUALLY. USE update.ps1
$url = 'https://releases.hashicorp.com/terraform/1.14.0-alpha20250903/terraform_1.14.0-alpha20250903_windows_386.zip'
$url64 = 'https://releases.hashicorp.com/terraform/1.14.0-alpha20250903/terraform_1.14.0-alpha20250903_windows_amd64.zip'
$checksum = '823b2970d6d580b4e558f0c1f71422c7cd84f1f3d835474c9de814baa89b3a41'
$checksum64 = '937ed3931cf93859f0543c76ec1f29989a76d28a50a7583bd604c1000639d231'

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
