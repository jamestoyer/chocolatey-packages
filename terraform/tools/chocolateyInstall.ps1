$url = 'https://dl.bintray.com/mitchellh/terraform/terraform_0.3.6_windows_386.zip'
$url64bit = 'https://dl.bintray.com/mitchellh/terraform/terraform_0.3.6_windows_amd64.zip'
$unzipLocation = "$env:SystemDrive\HashiCorp\terraform"

$terraformExe = $unzipLocation + "\terraform.exe"

If (Test-Path $terraformExe) {
  Write-Host "Removing old version"

  # This is only here until 'UnInstall-ChocolateyZipPackage' works again
  try {
    $zipFileName = "terraformInstall.zip"
    $packagelibPath=$env:chocolateyPackageFolder
    $zipContentFile=(join-path $packagelibPath $zipFileName) + ".txt"
    $zipContents=get-content $zipContentFile
    foreach ($fileInZip in $zipContents) {
      remove-item "$fileInZip" -ErrorAction SilentlyContinue
    }
  } catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
  }
}

Install-ChocolateyZipPackage "terraform" "$url" "$unzipLocation" "$url64bit"
Install-ChocolateyPath $unzipLocation
