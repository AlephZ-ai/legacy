#!/bin/zsh
#shellcheck shell=bash
# init
set -e
# shellcheck source=/dev/null
source "$HOME/.zshrc"
# Disable needing password for sudo
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/disable-sudo-password.sh"
# Setup Developer Command Line tools
if ! (bash --version && git --version); then sudo xcode-select --install; fi
# build commands
# shellcheck source=/dev/null
export HOMEBREW_PREFIX="/usr/local"
bash -l -c "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/post-build-user.sh"
# shellcheck source=/dev/null
source "$HOME/.zshrc"
# Add docker path
# shellcheck source=/dev/null
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'PATH="$HOME/.docker/bin:$PATH"'
# Continue with devspace setup
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/macos/brew.sh"
# Continue with devspace setup
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace.sh"
# Login to GitHub
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/gh-login.sh"
# Login to Docker
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/docker-login.sh"
# Done
echo "Please restart shell to get latest environment variables"
