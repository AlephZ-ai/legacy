#!/usr/bin/env bash
set -euo pipefail
if command -v pip --version >/dev/null 2>&1; then
  files=("$HOME/.pip/pip.conf" "$HOME/.config/pip/pip.conf")
  for file in "${files[@]}"; do
    if [ -e "$file" ]; then
      sed -i.bak 's/no-cache-dir = .*/no-cache-dir = false/' "$file"
      echo "$file"
    fi
  done

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
