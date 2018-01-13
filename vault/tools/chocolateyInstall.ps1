$checksum = 'fd5bd46eb10951cf3d35cbff4d00e6c4e1110311d6e86968d997d4bf294db8b9'
$checksum64 = '118fa03cbdc9629da151d42f8b023751ac7cdf94b072f584f1513f1748bdf8e8'
$url = 'https://releases.hashicorp.com/vault/0.9.0/vault_0.9.0_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/vault/0.9.0/vault_0.9.0_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "vault" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
