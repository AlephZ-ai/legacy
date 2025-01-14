Write-Host "setup/windows/powershell.ps1"
# Make sure profile exists
if (!(Test-Path $PROFILE)) {
  New-Item -ItemType File -Path $PROFILE -Force | Out-Null
}

# Define an array of module names
$modules = @('Pester', 'Set-PsEnv', 'posh-docker', 'posh-git', 'lazy-posh-git')
# Windows PowerShell
Install-Module PowerShellGet -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber
Install-Module PowerShellGet -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber -AllowPrerelease
Install-Module PackageManagement -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber;
Register-PSRepository -Default
Set-Alias -Name awk -Value gawk
foreach ($module in $modules) {
  Install-Module $module -Force -SkipPublisherCheck -AllowClobber
}
