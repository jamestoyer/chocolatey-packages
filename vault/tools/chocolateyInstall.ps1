$checksum = '6a39b91e72fa8743b76b998ecdf9432acf6f75b98e9975c3f5cad49d5597146d'
$checksum64 = '44b9f7b9c87b2c5df71a2462518299bfb165b9c3fd839d2ff817acce9af3a9e4'
$url = 'https://releases.hashicorp.com/vault/0.7.3/vault_0.7.3_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/vault/0.7.3/vault_0.7.3_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
