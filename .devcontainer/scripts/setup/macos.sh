#!/usr/bin/env zsh
#shellcheck shell=bash
# init
  set -e
  # shellcheck source=/dev/null
  source "$HOME/.zshrc"
# Setup Developer Command Line tools
  if ! (bash --version && git --version); then sudo xcode-select --install; fi
# Run post-build commands
  # shellcheck source=/dev/null
  export HOMEBREW_PREFIX="/usr/local"
  bash -l -c "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/post-build-user.sh"
  # shellcheck source=/dev/null
  source "$HOME/.zshrc"
# Continue with devspace setup
  "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace.sh"
# Login to GitHub
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/gh-login.sh"
# Login to Docker
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/docker-login.sh"
# Done
  echo "Please restart shell to get latest environment variables"
