#!/usr/bin/env bash
set -euo pipefail
devspace=devspace
devspaceExists=$(pyenv virtualenvs --bare | grep -qoP "^$devspace\$" && echo true || echo false)
if $devspaceExists; then pyenv activate $devspace; fi
if [ "$FAST_LEVEL" -eq 0 ]; then
  "$DEVCONTAINER_SCRIPTS_ROOT/uninstall/pip/packages.sh"
  "$DEVCONTAINER_SCRIPTS_ROOT/uninstall/pip/package-cache.sh"
fi

for venv in $(pyenv virtualenvs --bare); do
  echo "Deleting virtualenv: $venv"
  pyenv virtualenv-delete -f "$venv"
done

for version in $(pyenv versions --bare); do
  echo "Uninstalling Python version: $version"
  pyenv uninstall -f "$version"
done

rm -rf "$HOME/.pip"
rm -rf "$HOME/.config/pip"
rm -rf "$HOME/.nvidia/pip"
