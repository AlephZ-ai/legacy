#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
# https://github.com/romkatv/powerlevel10k
# https://github.com/romkatv/powerlevel10k#installation
# https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k
# init
set -euo pipefail
echo -e "Installing romkatv/powerlevel10k"
themes="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes"
plpath="$themes/romkatv"
if [ ! -d "$plpath" ]; then
  mkdir -p "$themes"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$plpath" &>/dev/null
fi

pushd "$plpath"
git pull
popd
"$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'ZSH_THEME="romkatv/powerlevel10k"'
