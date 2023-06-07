#!/bin/bash
set -e
if command -v brew --version >/dev/null 2>&1; then
  brew uninstall --force --ignore-dependencies pycairo py3cairo pygobject3 pyenv pipx
  brew uninstall --force --ignore-dependencies --cask miniconda anaconda
fi

"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/pip/packages.sh"
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/pip/package-cache.sh"
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/asdf.sh"
if command -v brew --version >/dev/null 2>&1; then
  while [[ $(brew list | wc -l) -ne 0 ]]; do
    for EACH in $(brew list); do
      brew uninstall --force --ignore-dependencies "$EACH"
    done
  done
fi
