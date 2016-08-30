$checksum = '8faf63bff47a6a8ba0287b2ff1b462baf0ec9319b450c2e6b5b5f8950a9e2e1c'
$checksum64 = '53df96e47f67096f408b5f003641671a01170c88c85058771ef46f880b61b5dc'
$url = 'https://releases.hashicorp.com/vault/0.6.1/vault_0.6.1_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/vault/0.6.1/vault_0.6.1_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
