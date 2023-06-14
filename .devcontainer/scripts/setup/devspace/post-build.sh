#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
# init
set -euo pipefail
HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-/home/linuxbrew/.linuxbrew}
USERNAME="${USERNAME:-$(whoami)}"
os=$(uname -s)
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
# TODO: Eventually remove this, it was causing double time of loading a new shell
# TODO: Consider if I should default to the these rcs for most things and only put some in the interactive rcs
# shellcheck disable=SC2016
# "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" '[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"' "$HOME/.bash_profile"
# shellcheck disable=SC2016
# "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" '[ -f "$HOME/.zshrc" ] && source "$HOME/.zshrc"' "$HOME/.zprofile"
# Add autogenerate line
"$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" '# ------- pre-generated above this line -------' all
"$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" '# ------- manual entry goes here -------' all
"$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" '# ------- auto-generated below this line -------' all
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'PATH=$HOME/bin:$PATH'
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'export MANPATH="/usr/local/man${MANPATH:+:}${MANPATH:-}"'
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' "$HOME/.zshrc"
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/zsh.sh"
# Setup Homebrew
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/brew.sh"
if [ "$os" = "Linux" ]; then
  sudo chsh "$USERNAME" -s "$(which zsh)"
fi

# Setup GH
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/gh.sh"
# Make trusted root CA then install and trust it (with mkcert)
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/trust-root-ca.sh"
# Make Edge the default browser if installed
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/edge-default.sh"
# Setup Condas
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/condas.sh"
# Setup rust
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/rust.sh"
# Setup adsf
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/asdf.sh"
# Setup dotnet
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/dotnet.sh"
# Make trusted root CA then install and trust it (with dotnet and mkcert)
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/trust-root-ca.sh"
# Setup pwsh modules
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/pwsh.sh"
# Setup pip
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/pip.sh"
# Setup az
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/az.sh"
# Setup nvm
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/nvm.sh"
# Setup desktop-list
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/desktop-lite.sh"
# Setup ohmyzsh plugins
source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/zsh/oh-my-zsh.sh"
