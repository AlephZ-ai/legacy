#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
# init
set -euo pipefail
echo -e "Installing powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" &>/dev/null || true
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'ZSH_THEME="powerlevel10k/powerlevel10k"' "$HOME/.zshrc"
echo -e "RECOMMENDED: Install Meslo Nerd Font patched for Powerlevel10k"
echo -e "https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k"
# TODO: Finish setting up
# https://github.com/romkatv/powerlevel10k
# https://github.com/romkatv/powerlevel10k#installation
# https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k
