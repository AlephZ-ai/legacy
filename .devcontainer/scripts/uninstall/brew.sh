#!/bin/bash
set -euo pipefail
os=$(uname -s)
if [ -z "${HOMEBREW_PREFIX:-}" ]; then
  if [ "$os" = "Linux" ]; then
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  else
    export HOMEBREW_PREFIX="/usr/local"
  fi
fi

"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/brew/brews.sh"
if [ "$FAST_LEVEL" -eq 0 ] && command -v brew --version >/dev/null 2>&1; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
fi

rm -rf "$HOME/brew"
sudo rm -rf "$HOMEBREW_PREFIX/Caskroom"
sudo rm -rf "$HOMEBREW_PREFIX/Cellar"
sudo rm -rf "$HOMEBREW_PREFIX/Homebrew"
