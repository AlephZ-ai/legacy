#!/usr/bin/env zsh
# shellcheck shell=bash
# init
set -euo pipefail
# Setup pwsh modules
echo "Setting up PowerShell modules, this can take a while..."
pwsh_modules=('Pester' 'Set-PsEnv' 'posh-docker' 'posh-git' 'lazy-posh-git' 'Az' 'AWS.Tools.Installer' 'PSReadLine'
  'SqlServer' 'PSScriptAnalyzer' 'dbatools')
# shellcheck disable=SC2016
pwsh_update='if (!(Test-Path $PROFILE)) { New-Item -ItemType File -Path $PROFILE -Force; }; Get-PSRepository | Set-PSRepository -InstallationPolicy Trusted; Install-Module PowerShellGet -ErrorAction Stop -SkipPublisherCheck; Install-Module PackageManagement -ErrorAction Stop -SkipPublisherCheck; Set-Alias -Name awk -Value gawk'
# shellcheck disable=SC2016
pwsh_install_module='Install-Module -Name $module -ErrorAction Stop -SkipPublisherCheck;'
pwsh_post_install='Update-Module;'
# shellcheck disable=SC2034
install_modules() {
  local pwsh=$1
  echo "Updating modules in $pwsh..."
  "$pwsh" -Command "$pwsh_update"
  for module in "${pwsh_modules[@]}"; do
    echo "Installing $module in $pwsh..."
    "$pwsh" -Command "$(eval echo "$pwsh_install_module")"
  done

  echo "Updating modules in $pwsh..."
  "$pwsh" -Command "$pwsh_post_install"
}

# PowerShell Core (pwsh)
if command -v pwsh >/dev/null; then install_modules "pwsh"; else echo "PowerShell Core is not installed"; fi
# PowerShell Core Preview (pwsh-preview)
if command -v pwsh-preview >/dev/null; then install_modules "pwsh-preview"; else echo "PowerShell Core Preview is not installed"; fi
