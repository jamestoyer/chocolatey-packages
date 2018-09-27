$checksum = '1f65c3d4a7537dbb5f72e30f90ddd98617651e8b45c37fa4c12e61390827066d'
$checksum64 = 'f581bb6b54a8d540dcafba8689968c4f60afda7ff194aebecc067ccbd3e3fb53'
$version = '0.11.1'
$url = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_386.zip"
$url64bit = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_amd64.zip"

$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
