#!/usr/bin/env zsh
# shellcheck shell=bash
# init
set -euo pipefail
moduleInstalled=$(pwsh -Command 'Get-Module -ListAvailable -Name posh-git')
if [ -z "$moduleInstalled" ]; then
  PWSH_FAST_LEVEL=0
else
  PWSH_FAST_LEVEL=${PWSH_FAST_LEVEL:-${FAST_LEVEL:-0}}
fi

echo "PWSH_FAST_LEVEL: $PWSH_FAST_LEVEL"
# Setup pwsh modules
if [ "$PWSH_FAST_LEVEL" -eq 0 ]; then
  pwshrc="$DEVCONTAINER_PROJECT_ROOT/rc/default.profile.ps1"
  pwsh_modules=('Pester' 'Set-PsEnv' 'posh-docker' 'posh-git' 'lazy-posh-git' 'Az' 'AWS.Tools.Installer' 'PSReadLine'
    'SqlServer' 'PSScriptAnalyzer' 'dbatools')
  # shellcheck disable=SC2016
  pwsh_update='pwsh -Command "$pwshrcContent = Get-Content -Path \"'$pwshrc'\" -Raw; if ((Get-Content -Path $PROFILE -Raw) -notcontains $pwshrcContent) { Add-Content -Path $PROFILE -Value $pwshrcContent }; Get-PSRepository | Set-PSRepository -InstallationPolicy Trusted; Install-Module PowerShellGet -ErrorAction Stop -SkipPublisherCheck; Install-Module PackageManagement -ErrorAction Stop -SkipPublisherCheck; Set-Alias -Name awk -Value gawk"'
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
fi
