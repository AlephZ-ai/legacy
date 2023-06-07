#!/bin/bash
set -e
files=("$HOME/.pip/pip.conf" "$HOME/.config/pip/pip.conf")
for file in "${files[@]}"; do if [ -e "$file" ]; then
  sed -i '.bak' '/no-cache-dir = .*/d' "$file"
  echo "$file"
fi; done

if command -v brew --version >/dev/null 2>&1; then
  brew uninstall --force --ignore-dependencies pycairo py3cairo pygobject3 pyenv pipx
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
