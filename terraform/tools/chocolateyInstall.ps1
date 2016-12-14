$checksum = '055586a3dac85f56c25666ea339b4f94a21fc23e450652f6f9b068b5fabdcba4'
$checksum64 = 'f2dc1d85da946c472388087565f769d3e112e8f1ebfba44e0421a0f17a9db56b'
$url = 'https://releases.hashicorp.com/terraform/0.7.13/terraform_0.7.13_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/terraform/0.7.13/terraform_0.7.13_windows_amd64.zip'
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
