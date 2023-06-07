#!/usr/bin/env bash
# shellcheck shell=bash
# init
set -e
# shellcheck source=/dev/null
source "$HOME/.bashrc"
# Setup pwsh modules
pwsh_modules=('Pester' 'Set-PsEnv' 'posh-docker' 'posh-git' 'lazy-posh-git' 'Az' 'AWS.Tools.Installer' 'PSReadLine'
  'SqlServer' 'ImportExcel' 'PSScriptAnalyzer' 'dbatools')
# shellcheck disable=SC2016
pwsh_update='if (!(Test-Path $PROFILE)) { New-Item -ItemType File -Path $PROFILE -Force; }; Install-Module PowerShellGet -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber; Install-Module PackageManagement -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber; Update-Module; Install-Module PowerShellGet -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber -AllowPrerelease; Set-Alias -Name awk -Value gawk'
# shellcheck disable=SC2016
pwsh_install_module='Install-Module $module -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber;'
# shellcheck disable=SC2034
install_modules() {
  local pwsh=$1
  "$pwsh" -Command "$pwsh_update"
  for module in "${pwsh_modules[@]}"; do $pwsh -Command "$(eval echo "$pwsh_install_module")"; done
}
# PowerShell Core (pwsh)
if command -v pwsh >/dev/null; then install_modules "pwsh"; else echo "PowerShell Core is not installed"; fi
# PowerShell Core Preview (pwsh-preview)
if command -v pwsh-preview >/dev/null; then install_modules "pwsh-preview"; else echo "PowerShell Core Preview is not installed"; fi
