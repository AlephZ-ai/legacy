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

  pip cache purge --no-input || true
fi
