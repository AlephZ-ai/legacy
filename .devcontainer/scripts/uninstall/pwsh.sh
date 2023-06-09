#!/usr/bin/env bash
set -euo pipefail
# shellcheck disable=SC2016
pwsh_uninstall_modules='Get-InstalledModule | ForEach-Object { Uninstall-Module -Name $_.Name -AllVersions -Force };'
uninstall_modules() {
  local pwsh=$1
  echo "Uninstalling modules in $pwsh..."
  "$pwsh" -Command "$pwsh_uninstall_modules"
}

# PowerShell Core (pwsh)
if [ "$FAST_LEVEL" -eq 0 ]; then
  if command -v pwsh >/dev/null; then uninstall_modules "pwsh"; else echo "PowerShell Core is not installed"; fi
  # PowerShell Core Preview (pwsh-preview)
  if command -v pwsh-preview >/dev/null; then uninstall_modules "pwsh-preview"; else echo "PowerShell Core Preview is not installed"; fi
fi

rm -rf "$HOME/.cache/powershell"
rm -rf "$HOME/.config/powershell"
rm -rf "$HOME/.local/share/powershell"
