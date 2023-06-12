#!/usr/bin/env bash
# shellcheck source=/dev/null
# init
set -euo pipefail
current_user="$(whoami)"
# Disable needing password for sudo
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/disable-sudo-password.sh"
# Update max open files
"$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "sudo $current_user soft nofile 4096" "/etc/security/limits.conf"
# Run pre-build commands
sudo -s DEVCONTAINER_SCRIPTS_ROOT="$DEVCONTAINER_SCRIPTS_ROOT" USERNAME="$current_user" bash -c "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/sudo/pre-build.sh"
# Run post-build commands
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/post-build.sh"
# Continue with devspace setup
zsh -l -c "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace.sh"
# Login to GitHub and Docker if not in WSL
if ! uname -r | grep -q microsoft; then
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/gh-login.sh"
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/docker-login.sh"
fi
