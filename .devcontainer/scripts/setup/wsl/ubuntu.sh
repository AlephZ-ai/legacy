#!/usr/bin/env bash
# shellcheck source=/dev/null
# init
set -euo pipefail
# Run base ubuntu setup
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/ubuntu.sh"
# Install WSL Utilties
# https://github.com/wslutilities/wslu
sudo apt update
sudo apt upgrade -y
sudo apt install -y --install-recommends wslu
browser='wslview'
cmds=("alias xdg-open=$browser" "export BROWSER=$browser")
for i in "${!cmds[@]}"; do
  cmd="${cmds[$i]}"
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "$cmd"
done

# Login to GitHub
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/gh-login.sh"
# Login to Docker
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/docker-login.sh"
# WSLg GPU acceleration
# glxinfo
