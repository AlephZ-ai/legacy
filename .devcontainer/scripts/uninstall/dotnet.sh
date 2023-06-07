#!/usr/bin/env bash
set -e
if command -v dotnet --version --version >/dev/null 2>&1; then
  for workload in $(dotnet workload list --machine-readable | cut -d ' ' -f 2); do
    dotnet workload uninstall "$workload"
  done

  dotnet tool list --tool-path "$HOME/.dotnet/tools/preview" | awk 'NR>2 {print $1}' | xargs -I {} -n1 dotnet tool uninstall --tool-path "$HOME/.dotnet/tools/preview" "{}"
  dotnet tool list -g | awk 'NR>2 {print $1}' | xargs -I {} -n1 dotnet tool uninstall -g "{}"
fi

rm -rf "$HOME/.dotnet"
