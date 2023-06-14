#!/usr/bin/env bash
set -euo pipefail
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
export DOTNET_ROLL_FORWARD=LatestMajor
# shellcheck disable=SC2155
if command -v dotnet >/dev/null 2>&1; then
  if command -v asdf >/dev/null 2>&1; then
    preview="$(asdf list dotnet-core 8 | tail -1)"
    preview="${preview##*\*}"
    # shellcheck disable=SC2001
    preview="$(echo "${preview}" | sed -e 's|^[[:space:]]*||')"
    export DOTNET_ROOT="$HOME/.asdf/installs/dotnet-core/$preview"
    "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.bash"
  elif command -v brew >/dev/null 2>&1; then
    export DOTNET_ROOT="$HOMEBREW_PREFIX/share/dotnet"
  fi

  export PATH="$DOTNET_ROOT:$PATH"
  export PATH="$HOME/.dotnet/tools:$PATH"
  export PATH="$HOME/.dotnet/tools/preview:$PATH"
  "$DEVCONTAINER_SCRIPTS_ROOT/uninstall/pwsh.sh"
  if command -v dotnet >/dev/null 2>&1; then
    dotnet tool list
    if [ "$FAST_LEVEL" -eq 0 ]; then
      if [ -e "$HOME/.dotnet/tools/preview" ]; then
        dotnet tool list --tool-path "$HOME/.dotnet/tools/preview" | awk 'NR>2 {print $1}' | xargs -I {} -n1 dotnet tool uninstall --tool-path "$HOME/.dotnet/tools/preview" "{}"
      fi

      dotnet tool list -g | awk 'NR>2 {print $1}' | xargs -n1 dotnet tool uninstall -g
      list=$(dotnet workload list | awk 'NR>3 && !/--/ && !/^Use / {print $1}')
      if [ -n "$list" ]; then
        for workload in $list; do
          dotnet workload uninstall "$workload"
        done
      fi
    fi
  fi
fi

rm -rf "$HOME/.aspnet"
rm -rf "$HOME/.dotnet"
rm -rf "$HOME/.nuget"
rm -rf "$HOME/.local/share/NuGet"
rm -rf "$HOME/.config/NuGet"
