#!/usr/bin/env zsh
# shellcheck shell=bash
# init
set -e
echo -e "Installing powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" &>/dev/null || true
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'ZSH_THEME="powerlevel10k/powerlevel10k"'
