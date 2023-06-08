#!/usr/bin/env bash
# init
set -e
USERNAME=${USERNAME:-}
# Update apt-packages
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/sudo/apt-install.sh"
# Install docker completions
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/sudo/docker-completions.sh"
# Install Microsoft Edge
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/sudo/edge-install.sh"
# Install OpenVINO
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/sudo/openvino.sh"
# Update apt-packages
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/sudo/apt-update.sh"
# Cleanup apt-packages
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/sudo/apt-cleanup.sh"
# Done
echo "Please restart shell to get latest environment variables"
