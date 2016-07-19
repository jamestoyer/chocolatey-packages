$url = 'https://releases.hashicorp.com/terraform/0.7.0-rc3/terraform_0.7.0-rc3_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/terraform/0.7.0-rc3/terraform_0.7.0-rc3_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage "terraform" "$url" "$unzipLocation" "$url64bit"
