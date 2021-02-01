$packageName  = 'teamspeak-server' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://files.teamspeak-services.com/releases/server/3.13.3/teamspeak3-server_win32-3.13.3.zip'
$checksum     = 'e69ae286b0b19bf1b0a86995348e75a1f2e4f64f546d18c917fb9f8bda482605'
$url64        = 'https://files.teamspeak-services.com/releases/server/3.13.3/teamspeak3-server_win64-3.13.3.zip'
$checksum64   = 'f69c37d4f755d432523b431396834836da30841a4fc4f2fd62b22a33e89f4e7e'
$shortcutName = 'TeamSpeak Server.lnk'
$exe          = 'ts3server.exe'

if ((Get-OSArchitectureWidth -eq 64) -and ($env:chocolateyForceX86 -ne $true))
    {
     $workingDir = 'teamspeak3-server_win64'
    } else {
     $workingDir = 'teamspeak3-server_win32'
    }

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64 
  checksum64     = $checksum64
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$workingDir\$exe" -WorkingDirectory "$toolsDir\$workingDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$workingDir\$exe" -WorkingDirectory "$toolsDir\$workingDir"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null
