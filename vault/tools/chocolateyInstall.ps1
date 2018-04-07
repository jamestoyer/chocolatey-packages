$checksum = '2241cc1cc711d056c8774e081965dec7a0c3524f32a622802e68c32726349915'
$checksum64 = '3a394704640239b4b8980c88822b2513fd7e9fa385f2eb7beb2bea990b9c0f04'
$version = '0.9.3'
$url = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_386.zip"
$url64bit = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_amd64.zip"

$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
