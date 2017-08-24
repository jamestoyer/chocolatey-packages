$checksum = '0a5e1ae2160e7237ebabc970b41e91fc42f5901000dcd185e8e7c74f532cc459'
$checksum64 = '19f04a5989027245c88ced39032157240a49f186646a4497a15e3cc2a4839ebb'
$url = 'https://releases.hashicorp.com/vault/0.8.1/vault_0.8.1_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/vault/0.8.1/vault_0.8.1_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
