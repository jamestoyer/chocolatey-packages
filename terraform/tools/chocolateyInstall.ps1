$url = 'https://dl.bintray.com/mitchellh/terraform/terraform_0.4.0_windows_386.zip'
$url64bit = 'https://dl.bintray.com/mitchellh/terraform/terraform_0.4.0_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage "terraform" "$url" "$unzipLocation" "$url64bit"
