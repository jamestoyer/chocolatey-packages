$checksum = '487e98ff32930f86083286fcd91cad8cb31f6639974eeb8f6c443eb40e5fde1b'
$checksum64 = '56cdfbfee5526def65d29c142dd76eae1451addc11ff3d980a07ccacddb6e142'
$url = 'https://releases.hashicorp.com/vault/0.6.3/vault_0.6.3_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/vault/0.6.3/vault_0.6.3_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
