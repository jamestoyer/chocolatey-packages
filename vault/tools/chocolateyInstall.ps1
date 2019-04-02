$packageArgs = @{
  PackageName         = "vault"
  Url                 = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_386.zip"
  UnzipLocation       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  Url64               = "https://releases.hashicorp.com/vault/$($version)/vault_$($version)_windows_amd64.zip"
  Checksum            = '895252424cbdc23ed524f63741fd472a7a04fe508a58dead76d9f6422b465729'
  ChecksumType        = 'sha256'
  Checksum64          = 'b26de17832cb3a49d49017f5a3509e53d83547c275c85f81e045e58670b4061c'
  version             = '1.1.0'  
}

Install-ChocolateyZipPackage @packageArgs