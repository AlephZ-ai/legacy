#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
# init
set -euo pipefail
HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-/home/linuxbrew/.linuxbrew}
USERNAME="${USERNAME:-$(whoami)}"
os=$(uname -s)
# Setup ohmyzsh and make zsh default shell
if [ "$os" = "Linux" ]; then
  sudo chsh "$USERNAME" -s "$(which zsh)"
fi

# Create /etc/bash.bashrc and /etc/zsh/zshrc if they don't exist
sudo touch /etc/bash.bashrc
sudo touch /etc/zsh/zshrc
sudo touch /etc/zsh/zshenv
touch "$HOME/.bash_profile"
touch "$HOME/.zprofile"
# Define the default rc files
if [ "$os" = "Linux" ]; then
  default_profile="$DEVCONTAINER_PROJECT_ROOT/rc/default.profile"
  default_zprofile="$DEVCONTAINER_PROJECT_ROOT/rc/default.zprofile"
  default_bashrc="$DEVCONTAINER_PROJECT_ROOT/rc/linux/default.bashrc"
  default_zshrc="$DEVCONTAINER_PROJECT_ROOT/rc/linux/default.zshrc"
else
  default_profile="$DEVCONTAINER_PROJECT_ROOT/rc/default.profile"
  default_zprofile="$DEVCONTAINER_PROJECT_ROOT/rc/default.zprofile"
  default_bashrc="$DEVCONTAINER_PROJECT_ROOT/rc/macos/default.bashrc"
  default_zshrc="$DEVCONTAINER_PROJECT_ROOT/rc/macos/default.zshrc"
fi

# Add default /etc/profile, ~/.bashrc, ~/.zshrc if they don't exist
if [ ! -f /etc/profile ]; then sudo cp "$default_profile" /etc/profile; fi
if [ ! -f /etc/zshrc ]; then sudo cp "$default_zprofile" /etc/zshrc; fi
if [ ! -f "$HOME/.bashrc" ]; then cp "$default_bashrc" "$HOME/.bashrc"; fi
if [ ! -f "$HOME/.zshrc" ]; then cp "$default_zshrc" "$HOME/.zshrc"; fi
# Add default setting to /etc/bash.bashrc and /etc/zsh/zshrc
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'source "$HOME/.bashrc"' "$HOME/.bash_profile"
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'source "$HOME/.zshrc"' "$HOME/.zprofile"
# Add autogenerate line
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" '# ------- pre-generated above this line -------' all
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" '# ------- manual entry goes here -------' all
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' "$HOME/.zshrc"
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" '# ------- auto-generated below this line -------' all
mv "$HOME/.zshrc" "$HOME/.og.zshrc"
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/zsh.sh"
# Restore the .zshrc
rm -rf "$HOME/.zshrc"
mv "$HOME/.og.zshrc" "$HOME/.zshrc"
# Setup Homebrew
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/brew.sh"
if [ "$os" = "Linux" ]; then
  sudo chsh "$USERNAME" -s "$(which zsh)"
fi

# Make trusted root CA then install and trust it
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/trust-root-ca.sh"
# Make Edge the default browser if installed
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/edge-default.sh"
# Setup Condas
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/condas.sh"
# Setup adsf
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/asdf.sh"
# Setup dotnet
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/dotnet.sh"
# Setup pwsh modules
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/pwsh.sh"
# Setup pip
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/pip.sh"
# Setup az
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/az.sh"
# Setup nvm
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/nvm.sh"
# Setup GH
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/gh.sh"
# Setup desktop-list
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/desktop-lite.sh"
# Setup ohmyzsh plugins
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/zsh/oh-my-zsh.sh"
