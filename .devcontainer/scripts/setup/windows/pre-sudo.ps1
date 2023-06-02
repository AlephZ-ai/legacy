Write-Host "setup/windows/pre-sudo.ps1"
# https://scoop.sh/
try {
  scoop --version | Write-Host
  if ($LASTEXITCODE -ne 0) { throw Write-Host "scoop --version failed"; "Exit code is $LASTEXITCODE" }
} catch {
  Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression | Write-Host
}

scoop bucket add extras | Write-Host
scoop bucket add games | Write-Host
scoop bucket add nerd-fonts | Write-Host
scoop bucket add nirsoft | Write-Host
scoop bucket add sysinternals | Write-Host
scoop bucket add java | Write-Host
scoop bucket add nonportable | Write-Host
scoop bucket add php | Write-Host
scoop bucket add versions | Write-Host
scoop update | Write-Host
scoop install sudo refreshenv python | Write-Host
scoop update --all | Write-Host
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows pip
refreshenv
