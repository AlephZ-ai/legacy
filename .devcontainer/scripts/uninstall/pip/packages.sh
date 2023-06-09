#!/usr/bin/env bash
set -euo pipefail
if command -v pip >/dev/null 2>&1; then
  "$DEVCONTAINER_SCRIPTS_ROOT/utils/pip-enable-cache.sh"
  # function to uninstall python packages
  uninstall_python_packages() {
    local user="${1-}"
    # shellcheck disable=SC2086
    eval "pip freeze $user | xargs -I {} pip uninstall -y $user '{}'"
  }

  # uninstall global python packages
  echo "Uninstalling user Python packages..."
  uninstall_python_packages "--user"
  echo "Uninstalling global Python packages..."
  uninstall_python_packages
fi
