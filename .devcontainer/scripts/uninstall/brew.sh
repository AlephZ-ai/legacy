#!/bin/bash
set -e
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/brew/brews.sh"
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
rm -rf "$HOME/brew"
sudo rm -rf "$HOMEBREW_PREFIX/Caskroom"
sudo rm -rf "$HOMEBREW_PREFIX/Cellar"
sudo rm -rf "$HOMEBREW_PREFIX/Homebrew"
