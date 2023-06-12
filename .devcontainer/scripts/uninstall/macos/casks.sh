#!/usr/bin/env bash
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
# shellcheck disable=SC2016
if command -v brew >/dev/null 2>&1; then
  eval "$(brew --prefix)/bin/brew shellenv)"
  if [ "$FAST_LEVEL" -eq 0 ]; then
    while [[ $(brew list --cask | wc -l) -ne 0 ]]; do
      for EACH in $(brew list --cask); do
        brew uninstall --cask --force --ignore-dependencies "$EACH"
      done
    done
  fi
fi
