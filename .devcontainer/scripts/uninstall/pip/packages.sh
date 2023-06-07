#!/usr/bin/env bash
set -e
if command -v pip --version >/dev/null 2>&1; then
  pip freeze | xargs -I {} pip uninstall -y "{}"
fi

rm -rf "$HOME/.pip"
