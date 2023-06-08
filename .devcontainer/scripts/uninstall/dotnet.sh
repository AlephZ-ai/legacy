#!/usr/bin/env bash
set -euo pipefail
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/pwsh.sh"
if command -v dotnet --version >/dev/null 2>&1; then
  if [ -e "$HOME/.dotnet/tools/preview" ]; then
    dotnet tool list --tool-path "$HOME/.dotnet/tools/preview" | awk 'NR>2 {print $1}' | xargs -I {} -n1 dotnet tool uninstall --tool-path "$HOME/.dotnet/tools/preview" "{}"
  fi

  dotnet tool list -g | awk 'NR>2 {print $1}' | xargs -n1 dotnet tool uninstall -g
  if command -v dotnet --version >/dev/null 2>&1; then
    list=$(dotnet workload list | awk 'NR>2 {print $1}')
    if [ -n "$list" ]; then
      for workload in $list; do
        dotnet workload uninstall "$workload" || true
      done
    fi
  fi
fi

rm -rf "$HOME/.aspnet"
rm -rf "$HOME/.dotnet"
rm -rf "$HOME/.nuget"
rm -rf "$HOME/.local/share/NuGet"
rm -rf "$HOME/.config/NuGet"
