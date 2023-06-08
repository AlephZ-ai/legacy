#!/usr/bin/env bash
# init
set -euo pipefail
# Run base ubuntu setup
# shellcheck source=/dev/null
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
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "$cmd"
done
# Login to GitHub
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/gh-login.sh"
# Login to Docker
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/docker-login.sh"
# WSLg GPU acceleration
# glxinfo
