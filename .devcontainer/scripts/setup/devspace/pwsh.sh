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

echo "PWSH_FAST_LEVEL=$PWSH_FAST_LEVEL"
# Setup pwsh modules
if [ "$PWSH_FAST_LEVEL" -eq 0 ]; then
  pwshrc="$DEVCONTAINER_PROJECT_ROOT/rc/default.profile.ps1"
  pwsh_modules=('Pester' 'Set-PsEnv' 'posh-docker' 'posh-git' 'lazy-posh-git' 'Az' 'AWS.Tools.Installer' 'PSReadLine'
    'SqlServer' 'PSScriptAnalyzer' 'dbatools')
  # shellcheck disable=SC2016
  pwsh_update='if (!(Test-Path -Path $PROFILE)) { New-Item -Force -Path $PROFILE -ItemType File | Out-Null; }; $pwshrcContent = Get-Content -Path \"'$pwshrc'\" -Raw; $profileContent = Get-Content -Path $PROFILE -Raw; if (-not $profileContent -or -not $profileContent.Contains($pwshrcContent)) { Add-Content -Path $PROFILE -Value $pwshrcContent; }; Get-PSRepository | ForEach-Object { Set-PSRepository -Name $_.Name -InstallationPolicy Trusted; }; Install-Module -Name PowerShellGet; Install-Module -Name PackageManagement;'
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
