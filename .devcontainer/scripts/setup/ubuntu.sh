#!/usr/bin/env bash
# init
set -euo pipefailuo pipefail
current_user="$(whoami)"
# Disable needing password for sudo
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/disable-sudo-password.sh"
# Update max open files
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "sudo $current_user soft nofile 4096" "/etc/security/limits.conf"
# Run pre-build commands
sudo -s DEVCONTAINER_SCRIPTS_ROOT="$DEVCONTAINER_SCRIPTS_ROOT" USERNAME="$current_user" bash -c "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/sudo/pre-build.sh"
# Run post-build commands
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/post-build.sh"
# Continue with devspace setup
zsh -l -c "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace.sh"
# Login to GitHub and Docker if not in WSL
if ! uname -r | grep -q microsoft; then
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/gh-login.sh"
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/docker-login.sh"
fi
