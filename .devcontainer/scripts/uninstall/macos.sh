#!/bin/zsh
# shellcheck source=/dev/null
# shellcheck shell=bash
set -euo pipefail
fast_level="${1:-0}"
unsafe_level="${2:-0}"
export FAST_LEVEL="${fast_level}"
export UNSAFE_LEVEL="${unsafe_level}"
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/nvm.sh"
if brew --version &>/dev/null; then
  brew uninstall --force --ignore-dependencies bash
  brew list --cask | xargs -I {} brew uninstall --cask "{}"
fi

"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/brew.sh"
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/zsh.sh"
rm -rf "$HOME/.iterm2"
rm -rf "$HOME/.config/iterm2"
# Remove autogenerate section from rc files
files=("$HOME/.bashrc" "$HOME/.zshrc")
for file in "${files[@]}"; do
  if [ -f "$file" ]; then
    sed -i.bak '/# ------- auto-generated below this line -------/,$d' "$file"
  fi
done

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
  echo -e "Deleteing /usr/local/*, /etc/zsh/zshrc, and ~/.zshrc"
  sudo rm -rf /usr/local/* &>/dev/null || true
  sudo rm -rf "/etc/zsh/zshrc"
  rm -rf "$HOME/.zshrc"
fi
