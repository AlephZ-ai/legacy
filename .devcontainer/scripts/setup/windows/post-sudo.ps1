scoop install --global sudo refreshenv #aria2
scoop update --all --global
#scoop config aria2-warning-enabled false
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows winget
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows chocolatey
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows scoop
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows dotnet-tools
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows nvm
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows pwsh
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows pip
# Setup environment
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup environment
try {
  gh auth status
} catch {
  gh auth login
}
gh config set -h github.com git_protocol https
gh auth status

git-credential-manager configure
git-credential-manager diagnose
winget install --id Microsoft.PowerToys --accept-package-agreements --accept-source-agreements --disable-interactivity
