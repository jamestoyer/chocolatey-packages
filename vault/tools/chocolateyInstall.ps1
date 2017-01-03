$checksum = '1a1d2c6eccc9ce2b9e71c83b222cecbaed71036068e5a7744708821eedefa024'
$checksum64 = '83db81056e7146513d7a2707ce1b6cf73ae8aa69f942f8cd92da49e1a7de86ca'
$url = 'https://releases.hashicorp.com/vault/0.6.4/vault_0.6.4_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/vault/0.6.4/vault_0.6.4_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
