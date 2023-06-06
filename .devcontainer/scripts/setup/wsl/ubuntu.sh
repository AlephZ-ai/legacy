#!/usr/bin/env bash
# init
set -e
# Run base ubuntu setup
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/ubuntu.sh"
# shellcheck source=/dev/null
source "$HOME/.bashrc"
# Install WSL Utilties
# https://github.com/wslutilities/wslu
sudo apt update
sudo apt upgrade -y
sudo apt install -y --install-recommends wslu
browser='wslview'
cmds=("alias xdg-open=$browser" "export BROWSER=$browser")
# shellcheck disable=SC2068
for i in ${!cmds[@]}; do
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
# Done
echo "Please restart shell to get latest environment variables"
