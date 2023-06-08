#!/usr/bin/env zsh
# shellcheck shell=bash
# init
set -euo pipefail
# Setup dotnet
preview="$(asdf list all dotnet-core 8 | tail -1)"
dotnet_latest_major_global='{ "sdk": { "rollForward": "latestmajor" } }'
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'export DOTNET_ROLL_FORWARD=LatestMajor'
echo "$dotnet_latest_major_global" >"$HOME/global.json"
# Update rc files
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export DOTNET_ROOT=\"\$HOME/.asdf/installs/dotnet-core/$preview\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.bash"
# Setup dotnet workloads
dotnet workload install --include-previews wasm-tools wasm-tools-net6 wasi-experimental android ios maccatalyst macos \
  maui maui-android maui-desktop maui-ios maui-maccatalyst maui-mobile maui-tizen tvos
# Clean, repair, and update
dotnet workload clean
dotnet workload update
dotnet workload repair
# Setup dotnet tools
# shellcheck source=/dev/null
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'PATH="$HOME/.dotnet/tools:$PATH"'
# shellcheck source=/dev/null
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'PATH="$HOME/.dotnet/tools/preview:$PATH"'
mkdir -p "$HOME/.dotnet/tools/preview"
echo "$dotnet_latest_major_global" >"$HOME/.dotnet/tools/global.json"
echo "$dotnet_latest_major_global" >"$HOME/.dotnet/tools/preview/global.json"
tools=('powershell' 'git-credential-manager' 'mlnet' 'microsoft.quantum.iqsharp' 'dotnet-ef' 'cake.tool'
  'microsoft.dotnet-httprepl' 'paket' 'benchmarkdotnet.tool' 'gitversion.tool' 'minver-cli' 'coverlet.console'
  'microsoft.tye' 'sourcelink' 'swashbuckle.aspnetcore.cli' 'wyam.tool' 'nbgv' 't-rex' 'microsoft.dotnet-try'
  'dotnet-script' 'microsoft.dotnet-interactive' 'dotnet-reportgenerator-globaltool' 'dotnet-outdated-tool' 'dotnet-depends'
  'dotnet-sonarscanner' 'dotnet-format' 'dotnet-t4' 'texttemplating.tool' 'dotnet-vstemplate' 'dotnet-codegencs' 'simplet'
  'dotnet-gcdump' 'dotnet-retire' 'dotnet-trace' 'dotnet-counters' 'dotnet-dump' 'dotnet-symbol'
  'dotnet-monitor' 'dotnet-sos' 'dotnet-sql-cache' 'dotnet-config' 'dotnet-grpc'
  'dotnet-dev-certs' 'dotnet-user-secrets' 'dotnet-watch' 'bundlerminifier.core.tool' 'amazon.lambda.tools'
  'dotnet-serve' 'dotnet-xdt' 'xunit-cli' 'nunit.consolerunner.netcore' 'nunit.runner' 'nunitreporter')
# shellcheck disable=SC2143
for tool in "${tools[@]}"; do
  installed_version=$(dotnet tool list -g | awk -v tool="$tool" '$1 == tool { print $2 }')
  latest_version=$(dotnet tool search "$tool" | awk -v tool="$tool" '$1 == tool' | awk '{print $2}')
  installed_prerelease_version=$(dotnet tool list --tool-path "$HOME/.dotnet/tools/preview" | awk -v tool="$tool" '$1 == tool { print $2 }')
  latest_prerelease_version=$(dotnet tool search "$tool" --prerelease | awk -v tool="$tool" '$1 == tool' | awk '{print $2}')
  found=true
  if [[ -z "$latest_version" ]]; then
    echo -e "Latest version of $tool not found, skipping..."
    found=false
  else
    if [[ -z "$installed_version" ]]; then
      echo -e "Installing $tool"
      dotnet tool install -g "$tool" --version "$latest_version"
    elif [[ "$installed_version" != "$latest_version" ]]; then
      echo -e "Updating $tool from version $installed_version to version $latest_version"
      dotnet tool update -g "$tool" --version "$latest_version"
    else
      echo -e "Latest version of $tool already installed"
    fi
  fi

  found_prerelease=true
  if [[ -z "$latest_prerelease_version" ]]; then
    found_prerelease=false
    echo -e "Latest prerelease version of $tool not found, skipping..."
  else
    if [ "$latest_version" != "$latest_prerelease_version" ]; then
      if [[ -z "$installed_prerelease_version" ]]; then
        echo -e "Installing prerelease $tool"
        dotnet tool install --tool-path "$HOME/.dotnet/tools/preview" "$tool" --version "$latest_prerelease_version"
      elif [[ "$installed_prerelease_version" != "$latest_prerelease_version" ]]; then
        echo -e "Updating $tool from version $installed_prerelease_version to prerelease $latest_prerelease_version"
        dotnet tool update --tool-path "$HOME/.dotnet/tools/preview" "$tool" --version "$latest_prerelease_version"
      else
        echo -e "Latest prerelease version of $tool already installed"
      fi
    fi
  fi

  if ! $found && ! $found_prerelease; then
    echo -e "Error: No versions found for $tool"
    exit 1
  fi

done
