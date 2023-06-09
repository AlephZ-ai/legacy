#!/usr/bin/env bash
set -euo pipefail
if command -v pip >/dev/null 2>&1; then
  "$DEVCONTAINER_SCRIPTS_ROOT/utils/pip-enable-cache.sh"
  pip cache purge --no-input
fi
