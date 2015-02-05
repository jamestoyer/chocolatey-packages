$unzipLocation = "$env:SystemDrive\HashiCorp\terraform"
Write-Host "Removing terraform commands"

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

If (-Not (Test-Path $unzipLocation\*)) {
  # Remove the folder if it is empty
  Remove-Item "$unzipLocation" -recurse
}
