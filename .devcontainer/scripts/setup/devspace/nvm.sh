#!/usr/bin/env bash
# shellcheck shell=bash
# init
set -e
# shellcheck source=/dev/null
source "$HOME/.bashrc"
# Setup nvm
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'export NVM_SYMLINK_CURRENT="true"'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
# shellcheck source=/dev/null
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"'
# shellcheck source=/dev/null
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm'
# shellcheck source=/dev/null
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion'
# Create default package.json
package_json=package.json
default_package_json='{ "name": "devspace" }'
echo "$default_package_json" | sudo tee $package_json
# Install Node.js latest and lts
nodes=('node' '--lts' 'node')
packages=('npm-check-updates' 'corepack' '@npmcli/fs' '@devcontainers/cli' 'dotenv-cli' 'typescript' 'azure-functions-core-tools@3')
for node in "${nodes[@]}"; do
  nvm install "$node"
  nvm use "$node"
  node --version
  npm update -g npm
  npm i -g "${packages[@]}"
  ncu -u
done
sudo rm -rf $package_json
