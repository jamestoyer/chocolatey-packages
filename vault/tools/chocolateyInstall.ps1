$checksum = '68059356c97dc3bb593e830e1556ed426d2a81150ba719b0033df9454084c106'
$checksum64 = 'cb8e58adb636246ad433e71861b2302b4963c10f3fc87bf9806e028f9479c01d'
$version = '0.10.0'
$url = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_386.zip"
$url64bit = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_amd64.zip"

$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
