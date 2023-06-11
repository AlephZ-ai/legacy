#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
# init
set -euo pipefail
echo -e "Installing romkatv/powerlevel10k"
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true'
themes="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes"
plpath="$themes/romkatv"
if [ ! -d "$plpath" ]; then
  mkdir -p "$themes"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$plpath" &>/dev/null || true
fi

if [ "$FAST_LEVEL" -eq 0 ]; then
  pushd "$plpath"
  git pull
  popd
fi

echo -e "RECOMMENDED: Install Meslo Nerd Font patched for Powerlevel10k"
echo -e "https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k"
# TODO: Finish setting up
# https://github.com/romkatv/powerlevel10k
# https://github.com/romkatv/powerlevel10k#installation
# https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k
