#!/usr/bin/env bash
set -e
if command -v pip --version >/dev/null 2>&1; then
  files=("$HOME/.pip/pip.conf" "$HOME/.config/pip/pip.conf")
  for file in "${files[@]}"; do
    if [ -e "$file" ]; then
      sed -i '.bak' '/no-cache-dir = .*/d' "$file"
      echo "$file"
    fi
  done

  # function to uninstall python packages
  uninstall_python_packages() {
    local user="$1"
    # shellcheck disable=SC2086
    pip freeze $user | xargs -I {} pip uninstall -y $user "{}" &>/dev/null
  }

  # uninstall global python packages
  echo "Uninstalling user Python packages..."
  uninstall_python_packages "--user"
  echo "Uninstalling global Python packages..."
  uninstall_python_packages
fi
