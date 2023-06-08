#!/bin/bash
set -euo pipefail
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/brew/brews.sh"
if command -v brew --version >/dev/null 2>&1; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
fi

rm -rf "$HOME/brew"
sudo rm -rf "$HOMEBREW_PREFIX/Caskroom"
sudo rm -rf "$HOMEBREW_PREFIX/Cellar"
sudo rm -rf "$HOMEBREW_PREFIX/Homebrew"
