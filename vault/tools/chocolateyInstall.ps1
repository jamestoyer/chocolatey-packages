$checksum = '5dfb575f7d93b9a44a6ba0be9f0bb35604c7f7636303e2ebc27007b97aa44713'
$checksum64 = 'dc9e9fda4cc89050b7a6ff9068acd548db52501be8028bd2f832ad3ef754ef9c'
$url = 'https://releases.hashicorp.com/vault/0.8.0/vault_0.8.0_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/vault/0.8.0/vault_0.8.0_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
