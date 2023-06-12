#!/usr/bin/env bash
# shellcheck source=/dev/null
set -euo pipefail
# shellcheck disable=SC2155
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME:-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME:-}/nvm")"
if [ -d "$NVM_DIR" ]; then
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

if [ "$FAST_LEVEL" -eq 0 ] && command -v nvm >/dev/null 2>&1; then
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
