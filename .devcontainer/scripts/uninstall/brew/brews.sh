#!/usr/bin/env bash
set -euo pipefail
if [ "$FAST_LEVEL" -eq 0 ] && command -v brew >/dev/null 2>&1; then
  while [[ $(brew list --formula | wc -l) -ne 0 ]]; do
    for EACH in $(brew list --formula); do
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
rm -rf "$HOME/.cargo"
