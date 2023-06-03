#!/usr/bin/env zsh
#shellcheck shell=bash
# init
  set -e
  # shellcheck source=/dev/null
  source "$HOME/.zshrc"
  updaterc() { local line="$1"; eval "$line"; echo "Updating ~/.bashrc and ~/.zshrc..."; rcs=("$HOME/.bashrc" "$HOME/.zshrc"); for rc in "${rcs[@]}"; do if [[ "$(cat "$rc")" != *"$line"* ]]; then echo "$line" >> "$rc"; fi; done }
# Disable needing password for sudo
  line="$USERNAME ALL=(ALL:ALL) NOPASSWD: ALL"
  file="/etc/sudoers.d/$USERNAME"
  sudo grep -qxF "$line" "$file" || echo "$line" | sudo tee --append "$file"
  sudo chmod 440 "$file"
# Setup Developer Command Line tools
  if ! (bash --version && git --version); then sudo xcode-select --install; fi
# Update permissions
  sudo chown -R "$(whoami)" /usr/local/* &> /dev/null || true
# Add docker path
  # shellcheck disable=SC2016
  updaterc 'PATH="$HOME/.docker/bin:$PATH"'
# build commands
  # shellcheck source=/dev/null
  export HOMEBREW_PREFIX="/usr/local"
  bash -l -c "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/post-build-user.sh"
  # shellcheck source=/dev/null
  source "$HOME/.zshrc"
# Continue with devspace setup
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/setup/macos/brew.sh"
# Continue with devspace setup
  "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace.sh"
# Login to GitHub
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/gh-login.sh"
# Login to Docker
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/docker-login.sh"
# Update permissions
  sudo chown -R "$(whoami)" /usr/local/* &> /dev/null || true
# Done
  echo "Please restart shell to get latest environment variables"
