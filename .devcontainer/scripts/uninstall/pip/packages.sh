#!/usr/bin/env bash
set -e
if command -v pip >/dev/null 2>&1; then
  pip freeze | xargs -I {} pip uninstall -y "{}"
fi
