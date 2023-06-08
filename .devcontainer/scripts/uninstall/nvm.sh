#!/usr/bin/env bash
set -euo pipefail
if command -v nvm --version --version >/dev/null 2>&1; then
  nodes=('node' '--lts')
  for node in "${nodes[@]}"; do
    nvm use "$node"
    npm ls -gp --depth=0 | awk -F/node_modules/ '{print $2}' | grep -vE '^npm$' | grep -v '^$' | xargs npm -g rm
    npm cache clean --force
  done
fi

rm -rf "$HOME/.npm" "$HOME/.bower"
if [[ -n "${NVM_DIR:-}" ]]; then
  rm -rf "$NVM_DIR"
fi
