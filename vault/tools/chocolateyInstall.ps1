$checksum = 'fecac943606c9549d026ce6aa6b98baf659b5f78f284e8ddcef81bb21199b24b'
$checksum64 = '5181a518ab1a8516ec1b155128282763a7794baa92b4c8cf502e5effc933383e'
$url = 'https://releases.hashicorp.com/vault/0.9.1/vault_0.9.1_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/vault/0.9.1/vault_0.9.1_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
