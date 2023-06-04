#!/usr/bin/env bash
# init
set -ex
# shellcheck source=/dev/null
source "$HOME/.bashrc"
# Setup dotnet
preview="$(asdf list all dotnet-core 8)"
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
dotnet workload install --include-previews wasi-experimental
# Clean, repair, and update
dotnet workload clean
dotnet workload update
dotnet workload repair
# Setup dotnet tools
tools=('powershell' 'git-credential-manager')
for tool in "${tools[@]}"; do if [ -z "$(dotnet tool list -g | grep -q "$tool")" ]; then dotnet tool update -g "$tool"; else dotnet tool install -g "$tool"; fi; done
# shellcheck source=/dev/null
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'PATH="$HOME/.dotnet/tools:$PATH"'
echo "$dotnet_latest_major_global" >"$HOME/.dotnet/tools/global.json"
