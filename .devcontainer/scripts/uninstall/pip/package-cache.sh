#!/usr/bin/env bash
set -e
if command -v pip --version >/dev/null 2>&1; then
  pip cache purge --no-input || true
fi
