#!/usr/bin/env bash
# shellcheck source=/dev/null
set -euo pipefail
devspace=devspace
if pyenv --version &>/dev/null; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  devspaceExists=$(pyenv virtualenvs --bare | grep -qx "^$devspace\$" && echo true || echo false)
  if $devspaceExists; then pyenv activate "$devspace"; fi
fi

if [ "$FAST_LEVEL" -eq 0 ]; then
  "$DEVCONTAINER_SCRIPTS_ROOT/uninstall/pip/packages.sh"
  "$DEVCONTAINER_SCRIPTS_ROOT/uninstall/pip/package-cache.sh"
fi

if pyenv --version &>/dev/null; then
  source deactivate
  for venv in $(pyenv virtualenvs --bare); do
    echo "Deleting virtualenv: $venv"
    pyenv virtualenv-delete -f "$venv"
  done

  for version in $(pyenv versions --bare); do
    echo "Uninstalling Python version: $version"
    pyenv uninstall -f "$version"
  done
fi

rm -rf "$HOME/.pip"
rm -rf "$HOME/.config/pip"
rm -rf "$HOME/.nvidia/pip"
