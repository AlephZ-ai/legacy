#!/bin/bash
# shellcheck source=/dev/null
set -euo pipefail
os=$(uname -s)
if [ -z "${HOMEBREW_PREFIX:-}" ]; then
  if [ "$os" = "Linux" ]; then
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  else
    export HOMEBREW_PREFIX="/usr/local"
  fi
fi

# Check fast level
export PATH="$HOMEBREW_PREFIX/bin:$PATH"
if [ "$FAST_LEVEL" -eq 0 ] && brew --version &>/dev/null; then
  brew uninstall --force --ignore-dependencies bash zsh
  brew uninstall --force --ignore-dependencies pycairo py3cairo pygobject3 pipx virtualenv
fi

"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/pip.sh"
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/asdf.sh"
if [ "$FAST_LEVEL" -eq 0 ] && brew --version &>/dev/null; then
  # Run Homebrew post install
  if [ -n "$BREW_POST_UNINSTALL" ]; then
    eval "$BREW_POST_UNINSTALL"
  fi
fi

"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/brew/brews.sh"
if [ "$FAST_LEVEL" -eq 0 ] && command -v brew >/dev/null 2>&1; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
fi

rm -rf "$HOME/brew"
sudo rm -rf "$HOMEBREW_PREFIX/Caskroom"
sudo rm -rf "$HOMEBREW_PREFIX/Cellar"
sudo rm -rf "$HOMEBREW_PREFIX/Homebrew"
