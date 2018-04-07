$checksum = '2d1646a3f65d318f0f019ede1d78fe2af705b603802d5a4f755f4eb6e7228acd'
$checksum64 = '5759a3355729648059584a0abc13bcac0a8d21c1c23db959c0795af1258734a4'
$version = '0.9.6'
$url = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_386.zip"
$url64bit = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_amd64.zip"

$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
