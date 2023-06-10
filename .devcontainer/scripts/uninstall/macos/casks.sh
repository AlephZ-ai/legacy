#!/bin/bash
set -euo pipefail
if [ "$FAST_LEVEL" -eq 0 ] && command -v brew >/dev/null 2>&1; then
  while [[ $(brew list --cask | wc -l) -ne 0 ]]; do
    for EACH in $(brew list --cask); do
      brew uninstall --cask --force --ignore-dependencies "$EACH"
    done
  done
fi
