$checksum = 'efdd4c064af9fe7ec5508ef07075a3c68192cd6a9ed3c68b201bbf9d5cd02112'
$checksum64 = '27f6f476650d61b1435bd8f24eca97ecabcb789e1e8a0f8388d59ac4f90517ad'
$url = 'https://releases.hashicorp.com/vault/0.7.1/vault_0.7.1_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/vault/0.7.1/vault_0.7.1_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
