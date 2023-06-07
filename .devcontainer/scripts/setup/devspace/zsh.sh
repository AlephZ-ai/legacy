#!/usr/bin/env bash
# init
set -e
# shellcheck source=/dev/null
source "$HOME/.bashrc"
USERNAME="${USERNAME:-$(whoami)}"
os=$(uname -s)
# Setup ohmyzsh and make zsh default shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
if [ "$os" = "Linux" ]; then
  sudo chsh "$USERNAME" -s "$(which zsh)"
fi

# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'plugins=(git, zsh-autosuggestions, zsh-syntax-highlighting, docker, docker-compose, npm, node, sudo, web-search, python, jsontools, dirhistory, extract, colored-man-pages, history, vi-mode, colorize, command-not-found, rails, ruby, adb, kubectl, osx, sublime, ssh-agent, gitfast, heroku, brew, golang, laravel, tmux, composer, symfony, npm, yarn, gradle, pip, jira, xcode, ember, gem, magento, vagrant, cakephp, wordpress, cordova, bundler)'

# powerlevel10k not working in wsl
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k" || true
#   rcFile="$HOME/.zshrc"
#   rcLine='source ~/powerlevel10k/powerlevel10k.zsh-theme'
#   grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
