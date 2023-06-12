#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
# init
set -euo pipefail
USERNAME="${USERNAME:-$(whoami)}"
# Setup ohmyzsh and make zsh default shell
if [ ! -e "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Setup compability
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'setopt localoptions ksharrays' "$HOME/.zshrc"

# Setup powerlevel10k zsh theme
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/zsh/powerlevel10k.sh"
