#!/usr/bin/env bash
# init
  set -ex
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
  USERNAME="${USERNAME:-$(whoami)}"
  os=$(uname -s)
# Setup ohmyzsh and make zsh default shell
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
  if [ "$os" == "Linux" ]; then
    sudo chsh "$USERNAME" -s "$(which zsh)"
  fi

  # powerlevel10k not working in wsl
  # git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k" || true
  #   rcFile="$HOME/.zshrc"
  #   rcLine='source ~/powerlevel10k/powerlevel10k.zsh-theme'
  #   grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
