Write-Host "setup/windows/chocolatey.ps1"
# https://chocolatey.org/
try {
  cup all -y | Write-Host
  if ($LASTEXITCODE -ne 0) { throw Write-Host "cup all -y failed" }
} catch {
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
  refreshenv
  . $profile
}

choco feature enable -n allowGlobalConfirmation | Write-Host
choco feature enable -n useRememberedArgumentsForUpgrades | Write-Host
choco feature enable -n showDownloadProgress | Write-Host
choco feature enable -n showNonElevatedWarnings | Write-Host
choco install -y vcredist-all | Write-Host
choco install -y psqlodbc | Write-Host
choco install -y sqlserver-odbcdriver | Write-Host
choco install -y sql-server-management-studio | Write-Host
cup all -y | Write-Host
