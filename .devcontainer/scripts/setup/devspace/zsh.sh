#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
# init
set -euo pipefail
# Backup the .zshrc
mv "$HOME/.zshrc" "$HOME/.og.zshrc"
# Setup ohmyzsh
if [ ! -e "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Restore the .zshrc
rm -rf "$HOME/.zshrc"
mv "$HOME/.og.zshrc" "$HOME/.zshrc"
# Setup powerlevel10k zsh theme
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/zsh/powerlevel10k.sh"
