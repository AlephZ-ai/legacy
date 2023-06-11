#!/usr/bin/env bash
set -euo pipefail
if pip --version &>/dev/null; then
  "$DEVCONTAINER_SCRIPTS_ROOT/utils/pip-enable-cache.sh"
  pip cache purge --no-input
fi
