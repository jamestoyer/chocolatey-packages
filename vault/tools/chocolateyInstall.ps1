$checksum = 'a29e86465cca8293f803aed62f25a34295e0ed79122ca855cedc5d3fb6611b12'
$checksum64 = '5395c306bfb033a426f3752a1070ec641372b32134e34f6cd43c53a3f2ed4946'
$url = 'https://releases.hashicorp.com/vault/0.8.2/vault_0.8.2_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/vault/0.8.2/vault_0.8.2_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
