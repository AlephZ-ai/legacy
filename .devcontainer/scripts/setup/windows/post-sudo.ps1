Write-Host "setup/windows/post-sudo.ps1"
scoop install --global sudo refreshenv  | Write-Host #aria2
scoop update --all --global | Write-Host
#scoop config aria2-warning-enabled false
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows powershell
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows winget
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows features
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows chocolatey
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows scoop
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows dotnet
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows nvm
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows pwsh
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows gh
# Setup environment
refreshenv
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup environment
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" utils gh-login
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" utils docker-login
winget install --id Microsoft.PowerToys --accept-package-agreements --accept-source-agreements --disable-interactivity | Write-Host
# The command above will fail if it's already installed, so make sure to have clean exit code
exit
