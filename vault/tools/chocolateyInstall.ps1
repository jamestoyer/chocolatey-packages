$checksum = 'a906a5263acb8ef1ad7726cc1ae5105d468e0c0ba7308664a13c6f7d01627652'
$checksum64 = '1ab014315e40374e58fd3474a37d5989d65936419e8d6311f4d530913f2378f5'
$version = '1.0.3'
$url = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_386.zip"
$url64bit = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_amd64.zip"

$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
