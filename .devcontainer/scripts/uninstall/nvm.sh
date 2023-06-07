#!/usr/bin/env bash
set -e
nodes=('node' '--lts')
for node in "${nodes[@]}"; do
  nvm use "$node"
  npm ls -gp --depth=0 | awk -F/node_modules/ '{print $2}' | grep -vE '^npm$' | grep -v '^$' | xargs npm -g rm
  npm cache clean --force
done

rm -rf "$NVM_DIR" "$HOME/.npm" "$HOME/.bower"
