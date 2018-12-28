$checksum = '1b89b13df0c0a537882ef1456bec02d016ccee56320b769cc825a241aa3a918b'
$checksum64 = '947277121a1a87b71bc0c6258b5ce83804461e2dadfc5529b58de0d22cf4b60d'
$version = '0.12.0-alpha4'
$url = "https://releases.hashicorp.com/terraform/$($version)/terraform_$($version)_terraform_$($version)_windows_386.zip"
$url64bit = "https://releases.hashicorp.com/terraform/$($version)/terraform_$($version)_terraform_$($version)_windows_amd64.zip"
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
