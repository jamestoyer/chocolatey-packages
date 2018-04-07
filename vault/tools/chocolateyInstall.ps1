$checksum = '269b56a3a956b4648f450881577d3c50d1808a5adede995819bc682763711b85'
$checksum64 = 'df19cf317809ab42561d5ef41c48ab337f5ec26ccc519ceb9d18a73e8bb825ee'
$version = '0.10.0-rc1'
$url = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_386.zip"
$url64bit = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_amd64.zip"

$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
