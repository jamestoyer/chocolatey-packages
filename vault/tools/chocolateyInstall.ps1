$checksum = '0273c2fc6afec1c8e2b62c610b675088d47d26d3a5dda801f23836baf566fe17'
$checksum64 = '66b71cdc72ebea0dc766af252963004fc4959f3a4bebdd2f5f9d67258967b877'
$url = 'https://releases.hashicorp.com/vault/0.6.2/vault_0.6.2_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/vault/0.6.2/vault_0.6.2_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
