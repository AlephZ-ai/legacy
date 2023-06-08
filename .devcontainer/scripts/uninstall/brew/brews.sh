#!/bin/bash
set -e
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/pip.sh"
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/asdf.sh"
if command -v brew --version >/dev/null 2>&1; then
  brew uninstall --force --ignore-dependencies pycairo py3cairo pygobject3 pyenv pipx virtualenv
  while [[ $(brew list | wc -l) -ne 0 ]]; do
    for EACH in $(brew list); do
      brew uninstall --force --ignore-dependencies "$EACH"
    done
  done
fi

rm -rf "$HOME/.azure"
rm -rf "$HOME/.kube"
rm -rf "$HOME/.minikube"
rm -rf "$HOME/.mono"
rm -rf "$HOME/.cache/powershell"
rm -rf "$HOME/.config/powershell"
rm -rf "$HOME/.local/share/powershell"
rm -rf "$HOME/.config/gcloud"
rm -rf "$HOME/.config/gh"
rm -rf "$HOME/.local/state/gh"
rm -rf "$HOME/postgres-data"
rm -rf "$HOME/go"
