$url = 'https://releases.hashicorp.com/terraform/0.6.12/terraform_0.6.12_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/terraform/0.6.12/terraform_0.6.12_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage "terraform" "$url" "$unzipLocation" "$url64bit"
