$checksum = '405d746a2d0b7f359d8579a82b1eedc94f69b210f4f10de2ccc3d62f58da3064'
$checksum64 = '9e64cd2a337fc25f9c29dbf5d1b1620527a53939f3d434fe5cea753552a72635'
$version = '0.9.2'
$url = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_386.zip"
$url64bit = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_amd64.zip"

$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
