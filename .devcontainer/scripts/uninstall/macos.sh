#!/bin/zsh
# shellcheck source=/dev/null
# shellcheck shell=bash
set -euo pipefail
source "$HOME/.zhrc"
fast_level="${1:-0}"
unsafe_level="${2:-0}"
export FAST_LEVEL="${fast_level}"
export UNSAFE_LEVEL="${unsafe_level}"
# shellcheck disable=SC2016
export BREW_POST_UNINSTALL='"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/macos/casks.sh"'
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/nvm.sh"
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/zsh.sh"
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/brew.sh"
rm -rf "$HOME/.iterm2"
rm -rf "$HOME/.config/iterm2"
# Remove autogenerate section from rc files
files=("$HOME/.bashrc" "$HOME/.zshrc")
for file in "${files[@]}"; do
  if [ -f "$file" ]; then
    sed -i.bak '/# ------- auto-generated below this line -------/,$d' "$file" && rm -rf "${file}.bak"
  fi
done

rm -rf ~/.antigen
sudo rm -rf "$HOME/.cache/Homebrew"
sudo rm -rf "$HOME/Library/Caches/Homebrew"
sudo rm -rf "$HOME/Library/Logs/Homebrew"
if [ "$UNSAFE_LEVEL" -ge 1 ]; then
  echo -e "WARNING: You chose at least unsafe level 1."
  echo -e "Deleteing /usr/local/{Frameworks,bin,etc,include,lib,opt,sbin,share,var}"
  sudo rm -rf /usr/local/Frameworks
  sudo rm -rf /usr/local/bin &>/dev/null || true
  sudo rm -rf /usr/local/etc
  sudo rm -rf /usr/local/include
  sudo rm -rf /usr/local/lib &>/dev/null || true
  sudo rm -rf /usr/local/opt
  sudo rm -rf /usr/local/sbin
  sudo rm -rf /usr/local/share
  sudo rm -rf /usr/local/var
fi

if [ "$UNSAFE_LEVEL" -ge 2 ]; then
  echo -e "WARNING: You chose at least unsafe level 2."
  echo -e 'Deleteing /usr/local/*, /etc/zshrc, /etc/zsh/zshrc, /etc/zsh/zshenv, ~/.zprofile, "~/.zshrc"*, /etc/profile, /etc/bash.bashrc, ~/.bash_profile and "~/.bashhrc"*'
  sudo rm -rf /usr/local/* &>/dev/null || true
  sudo rm -rf "/etc/zshrc"
  sudo rm -rf "/etc/zsh/zshrc"
  sudo rm -rf "/etc/zsh/zshenv"
  sudo rm -rf "/etc/profile"
  sudo rm -rf "/etc/bash.bashrc"
  rm -rf "$HOME/.zprofile"
  rm -rf "$HOME/.zshrc"* || true
  rm -rf "$HOME/.bash_profile"
  rm -rf "$HOME/.bashrc"* || true
fi

if [ "$UNSAFE_LEVEL" -ge 3 ]; then
  echo -e "WARNING: You chose at least unsafe level 3."
  echo -e 'Deleteing Library/Developer/CommandLineTools'
  sudo rm -rf /Library/Developer/CommandLineTools
fi
