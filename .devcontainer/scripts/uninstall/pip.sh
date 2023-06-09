#!/usr/bin/env bash
set -euo pipefail
if [ "$FAST_LEVEL" -eq 0 ]; then
  "$DEVCONTAINER_SCRIPTS_ROOT/uninstall/pip/packages.sh"
  "$DEVCONTAINER_SCRIPTS_ROOT/uninstall/pip/package-cache.sh"
fi

rm -rf "$HOME/.pip"
rm -rf "$HOME/.config/pip"
rm -rf "$HOME/.nvidia/pip"
