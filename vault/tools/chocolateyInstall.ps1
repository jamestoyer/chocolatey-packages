$checksum = '1fb1d837a085e1feceae00753b496735db746674ad3c55938f50545d1607dc32'
$checksum64 = '9cdef19513bc0e8d51a2764505bbcda3b5caa3db83f4fbe2c64cd2d0d6e5779c'
$url = 'https://releases.hashicorp.com/vault/0.8.3/vault_0.8.3_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/vault/0.8.3/vault_0.8.3_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
