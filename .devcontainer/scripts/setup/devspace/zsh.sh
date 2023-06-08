#!/usr/bin/env zsh
# shellcheck shell=bash
# init
set -euo pipefail
USERNAME="${USERNAME:-$(whoami)}"
# Setup ohmyzsh and make zsh default shell
if [ ! -e "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Setup powerlevel10k zsh theme
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/zsh/powerlevel10k.sh"
