#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
# init
set -euo pipefail
# Setup asdf
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'PATH="$HOME/.asdf/shims:$PATH"'
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "source \"$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh\""
asdf plugin list | grep -q dotnet-core || asdf plugin add dotnet-core https://github.com/emersonsoares/asdf-dotnet-core.git
asdf plugin update --all
preview="$(asdf list all dotnet-core 8 | tail -1)"
current="$(asdf list all dotnet-core 7 | tail -1)"
lts="$(asdf list all dotnet-core 6 | tail -1)"
versions=("$preview" "$current" "$lts" "$preview")
# shellcheck disable=SC2143
for version in "${versions[@]}"; do
  if [ -z "$(asdf list dotnet-core "$version")" ]; then
    asdf install dotnet-core "$version"
  else
    echo "dotnet-core $version already installed"
  fi

  asdf global dotnet-core "$version"
  asdf reshim
  dotnet --version
  asdf info
done

source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export DOTNET_ROOT=\"\$HOME/.asdf/installs/dotnet-core/$preview\""
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.bash"
