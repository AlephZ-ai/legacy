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

  pip freeze | xargs -I {} pip uninstall -y "{}"
fi
