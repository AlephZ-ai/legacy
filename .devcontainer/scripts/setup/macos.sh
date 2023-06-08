#!/usr/bin/env zsh
#shellcheck shell=bash
# shellcheck source=/dev/null
# init
set -euo pipefail
# Disable needing password for sudo
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/disable-sudo-password.sh"
# Setup Developer Command Line tools
if ! (bash --version && git --version); then sudo xcode-select --install; fi
# build commands
export HOMEBREW_PREFIX="/usr/local"
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
