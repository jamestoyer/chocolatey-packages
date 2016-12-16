$checksum = 'fa5c5fd00b8fe55034344c4d7f633a62a591d83a524f33f551ca5547497b5e93'
$checksum64 = '61a7b5cfd3587665ba99b855800c3e7d662b917be68b24dee1f11a59653ab1a2'
$url = 'https://releases.hashicorp.com/terraform/0.8.1/terraform_0.8.1_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/terraform/0.8.1/terraform_0.8.1_windows_amd64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

if ([System.IO.Directory]::Exists("$env:ChocolateyInstall\lib\terraform")) {
  if ([System.IO.Directory]::Exists("$env:ChocolateyInstall\lib\terraform\tools")) {
    # clean old plugins and ignore files
    Write-Host "Removing old terraform plugins"
    Remove-Item "$env:ChocolateyInstall\lib\terraform\tools\terraform-*.*"
  }
} else {
  if ([System.IO.Directory]::Exists("$env:ALLUSERSPROFILE\chocolatey\lib\terraform")) {
    if ([System.IO.Directory]::Exists("$env:ALLUSERSPROFILE\chocolatey\lib\terraform\tools")) {
      # clean old plugins and ignore files
      Write-Host "Removing old terraform plugins"
      Remove-Item "$env:ALLUSERSPROFILE\chocolatey\lib\terraform\tools" -Include "terraform-*.*"
    }
  }
}

Install-ChocolateyZipPackage -PackageName "terraform" -Url "$url" -UnzipLocation "$unzipLocation" -Url64 "$url64bit" -ChecksumType 'sha256' -Checksum "$checksum" -Checksum64 "$checksum64"
