$checksum = '0f175e7c90de03cb022a82116c9bb60d542cac4d8bfb0e30c9b0eeccc2343083'
$checksum64 = '4d0b517907f708eae43b85f96ea5a6c92842a7350aaa20a88600d9e2589a1afb'
$version = '0.9.4'
$url = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_386.zip"
$url64bit = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_amd64.zip"

$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
