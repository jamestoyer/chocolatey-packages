$checksum = '50541390d4de9e8906ad60eab2f527ec18660a5e91c3845f7d15e83416706730'
$checksum64 = 'c4d4556665709e0e5b11000413f046e23b365eb97eed9ee04f1a5c2598649356'
$url = 'https://releases.hashicorp.com/vault/0.7.0/vault_0.7.0_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/vault/0.7.0/vault_0.7.0_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
