$checksum = 'e5a7c38c9ce64458bd7cd0c258bc00df83921ece30f668e135d2bfc051aec642'
$checksum64 = 'd7c220da2f0b9a52d686cbb7278d27fba3af8dd02d785dfe33c4c6e96df27100'
$url = 'https://releases.hashicorp.com/terraform/0.9.4/terraform_0.9.4_windows_386.zip'
$url64bit = 'https://releases.hashicorp.com/terraform/0.9.4/terraform_0.9.4_windows_amd64.zip'
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
