$checksum = '0ed812c3a16720058c6e92a9a552ccc5d73c6d8d6fbd89e372a19e57a7b0a185'
$checksum64 = '718139c6f4bd918d5f94cd380b7b8db4664915d8d64acba0792a31ba102025a8'
$url = 'https://releases.hashicorp.com/vault/0.7.2/vault_0.7.2_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/vault/0.7.2/vault_0.7.2_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
