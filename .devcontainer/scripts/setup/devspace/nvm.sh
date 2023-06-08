#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
# init
set -euo pipefail
# Setup nvm
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'export NVM_SYMLINK_CURRENT="true"'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"'
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm'
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion'
# Create default package.json
package_json=package.json
default_package_json='{ "name": "devspace" }'
echo "$default_package_json" | sudo tee $package_json
# Install Node.js latest and lts
nodes=('node' '--lts' 'node')
packages=('npm' 'npx' 'npm-check-updates' 'corepack' '@npmcli/fs' '@devcontainers/cli' 'dotenv-cli' 'typescript' 'tsc'
  'azure-functions-core-tools@3' 'nodemon' 'yarn' 'grunt'' gulp' 'webpack' 'bower' 'create-react-app' 'express'
  'vue-cli' 'angular-cli' 'react-native-cli' 'babel-cli' 'gulp-cli' 'webpack-cli' 'sequelize-cli' 'generator-angular'
  'mocha' 'eslint' 'jshint' 'standard' 'tslint' 'pm2' 'cordova' 'ionic' 'karma' 'browserify' 'rollup' 'less' 'sass'
  'prettier' 'http-server' 'serve' 'forever' 'concurrently' 'cross-env' 'newman' 'lerna' 'yeoman' 'knex' 'husky'
  'commitizen' 'ava' 'jest' 'storybook' 'apidoc' 'coffeescript' 'node-gyp' 'node-pre-gyp' 'node-sass' 'gitmoji-cli')
for node in "${nodes[@]}"; do
  echo -e "Installing Node.js $node"
  nvm install "$node"
  nvm use "$node"
  node --version
  echo -e "Installing npm packages in $node"
  npm i -g "${packages[@]}"
  echo -e "Updating npm packages in $node"
  ncu -u -g
  npm update -g
done

sudo rm -rf $package_json
