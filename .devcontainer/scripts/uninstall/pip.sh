#!/usr/bin/env bash
set -euo pipefail
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/pip/packages.sh"
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/pip/package-cache.sh"
rm -rf "$HOME/.pip"
rm -rf "$HOME/.config/pip"
