#!/usr/bin/env bash
set -euo pipefail
if command -v pip >/dev/null 2>&1; then
  "$DEVCONTAINER_SCRIPTS_ROOT/utils/pip-enable-cache.sh"
  # uninstall python packages
  pip freeze | while read -r pkg; do pip uninstall -y "$pkg" || true; done
fi
