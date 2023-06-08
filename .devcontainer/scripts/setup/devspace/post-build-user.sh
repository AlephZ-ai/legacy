#!/usr/bin/env bash
# init
# shellcheck source=/dev/null
set -e
source "$HOME/.bashrc"
HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-/home/linuxbrew/.linuxbrew}
USERNAME="${USERNAME:-$(whoami)}"
# Setup ohmyzsh and make zsh default shell
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/zsh.sh"
# Setup Condas
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/condas.sh"
# Setup Homebrew
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/brew.sh"
# Make Edge the default browser if installed
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/edge-default.sh"
# Setup java
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/java.sh"
# Setup adsf
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/asdf.sh"
# Setup dotnet
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/dotnet.sh"
# Make trusted root CA then install and trust it
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/trust-root-ca.sh"
# Setup pwsh modules
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/pwsh.sh"
# Setup pip
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/pip.sh"
# Setup az
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/az.sh"
# Setup nvm
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/nvm.sh"
# Setup GH
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/gh.sh"
# Setup desktop-list
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/desktop-lite.sh"
# Setup ohmyzsh plugins
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/omz.sh"
# Done
echo "Please restart shell to get latest environment variables"
