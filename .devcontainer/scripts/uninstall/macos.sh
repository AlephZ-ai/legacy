#!/bin/zsh
# shellcheck shell=bash
set -e
unsafe_level="$1"
if nvm --version &>/dev/null && npm --version &>/dev/null; then
  # shellcheck source=/dev/null
  "$DEVCONTAINER_SCRIPTS_ROOT/uninstall/nvm.sh"
fi

if brew --version &>/dev/null; then
  brew uninstall --force --ignore-dependencies bash
  "$DEVCONTAINER_SCRIPTS_ROOT/uninstall/brew.sh"
fi

if [[ $(brew list --cask &>/dev/null) ]]; then
  brew list --cask | xargs -I {} brew uninstall --cask "{}"
fi

# Remove autogenerate section from rc files
sed -i '' '/# ------- auto-generated below this line -------/,$d' "$HOME/.bashrc"
sed -i '' '/# ------- auto-generated below this line -------/,$d' "$HOME/.zshrc"

sudo rm -rf "$HOME/.cache/Homebrew"
sudo rm -rf "$HOME/Library/Caches/Homebrew"
sudo rm -rf "$HOME/Library/Logs/Homebrew"
if [ "$unsafe_level" -ge 1 ]; then
  echo -e "WARNING: You chose at least unsafe level 1. I'm deleting the above directories"
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

if [ "$unsafe_level" -ge 2 ]; then
  echo -e "WARNING: You chose at least unsafe level 2. I am deleteing /usr/local/*"
  sudo rm -rf /usr/local/* &>/dev/null || true
fi
