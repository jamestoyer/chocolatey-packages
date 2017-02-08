$checksum = 'cfc5a9a7beecdf7e7b8424d706b5f39c1d757f329e6ec490fb627d58f147d51e'
$checksum64 = '4ef04179efba3233f1b1fb91c6702a5c7896b1e7d0d7398500a9c0729e81edf7'
$url = 'https://releases.hashicorp.com/vault/0.6.5/vault_0.6.5_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/vault/0.6.5/vault_0.6.5_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
