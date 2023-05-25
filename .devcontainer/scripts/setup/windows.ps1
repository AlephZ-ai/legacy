# Run this in Windows PowerShell as non-admin
# Please make sure winget is is installed
# https://apps.microsoft.com/store/detail/app-installer/
# https://github.com/microsoft/winget-cli
# https://github.com/microsoft/winget-cli/issues/210
& "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup/windows sudo
refreshenv
& "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup/windows winget
refreshenv
& "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup/windows chocolatey
refreshenv
& "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup/windows scoop
refreshenv
& "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup/windows dotnet-tools
refreshenv
& "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup/windows nvm
refreshenv
# Setup environment
& "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup environment
try {
  gh auth status
} catch {
  gh auth login
}
gh config set -h github.com git_protocol https
gh auth status

git-credential-manager configure
git-credential-manager diagnose
Write-Host "Don't forget to set your git credentials:"
Write-Host 'git config --global user.name "Your Name"'
Write-Host 'git config --global user.email "youremail@yourdomain.com"'
sudo winget install --id Microsoft.PowerToys