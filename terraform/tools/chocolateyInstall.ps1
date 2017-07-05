$checksum = '285d441907cc243f9679e459ae114c22aeb45ffee39439cf7e151c6ebe8fcf68'
$checksum64 = '08174d714eaa1c5bd13dd116adba62809d6860383ba90638dc330a0133dbb519'
$url = 'https://releases.hashicorp.com/terraform/0.9.10/terraform_0.9.10_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/terraform/0.9.10/terraform_0.9.10_windows_amd64.zip'
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
