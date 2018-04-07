$checksum = '1d22b82bb2ec2378061f6b45e6280bd3915754acead7ff912644508249d40a2a'
$checksum64 = '50a25a66836e45e890dcf197d510e0e6ff44fc6e1e41a34746e6fd184a9be6df'
$version = '0.9.5'
$url = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_386.zip"
$url64bit = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_amd64.zip"

$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
