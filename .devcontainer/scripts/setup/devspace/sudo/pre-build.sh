#!/usr/bin/env bash
# shellcheck source=/dev/null
# init
set -euo pipefail
USERNAME=${USERNAME:-}
# Update apt-packages
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/sudo/apt-install.sh"
# Install docker completions
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/sudo/docker-completions.sh"
# Install Microsoft Edge
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/sudo/edge-install.sh"
# Install OpenVINO
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/sudo/openvino.sh"
# Update apt-packages
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/sudo/apt-update.sh"
# Cleanup apt-packages
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/sudo/apt-cleanup.sh"
