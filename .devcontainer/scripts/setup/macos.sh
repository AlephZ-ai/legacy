#!/usr/bin/env zsh
#shellcheck shell=bash
# shellcheck source=/dev/null
# init
set -euo pipefail
fast_level="${1:-0}"
export FAST_LEVEL="${fast_level}"
echo "FAST_LEVEL=$FAST_LEVEL"
# Disable needing password for sudo
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/disable-sudo-password.sh"
# Setup Developer Command Line tools
if ! (bash --version && git --version); then sudo xcode-select --install; fi
# Setup required homebrew prefix on mac, this cannot be changed
export HOMEBREW_PREFIX="/usr/local"
# Create /etc/bash.bashrc and /etc/zsh/zshrc if they don't exist
sudo touch /etc/bash.bashrc
sudo touch /etc/zsh/zshrc
# Define the default rc files
default_bashrc="$(cat "$DEVCONTAINER_PROJECT_ROOT/rc/macos/default.bashrc")"
default_zshrc="$(cat "$DEVCONTAINER_PROJECT_ROOT/rc/macos/default.zshrc")"
# Add default ~/.bashrc and ~/.zshrc if they don't exist
if [ ! -f "$HOME/.bashrc" ]; then cp "$default_bashrc" "$HOME/.bashrc"; fi
if [ ! -f "$HOME/.zshrc" ]; then cp "$default_zshrc" "$HOME/.zshrc"; fi
# post build commands
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/post-build.sh"
# Add docker path
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'PATH="$HOME/.docker/bin:$PATH"'
# Continue with devspace setup
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/macos/brew.sh"
# Continue with devspace setup
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace.sh"
# Login to GitHub
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/gh-login.sh"
# Login to Docker
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/docker-login.sh"
