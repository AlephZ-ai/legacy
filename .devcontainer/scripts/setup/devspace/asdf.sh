#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
# init
set -euo pipefail
# Setup asdf
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'source "$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh"'
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'PATH="$HOME/.asdf/shims:$PATH"'
if asdf plugin list 2>/dev/null | grep -q dotnet-core &>/dev/null; then
  export ASDF_FAST_LEVEL=${ASDF_FAST_LEVEL:-${FAST_LEVEL:-0}}
else
  export ASDF_FAST_LEVEL=0
  asdf plugin add dotnet-core https://github.com/emersonsoares/asdf-dotnet-core.git
fi

echo "ASDF_FAST_LEVEL=$ASDF_FAST_LEVEL"
if [ "$ASDF_FAST_LEVEL" -eq 0 ]; then
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
    source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export DOTNET_ROOT=\"\$HOME/.asdf/installs/dotnet-core/$version\""
    dotnet --version
    asdf info
  done
else
  preview="$(asdf list dotnet-core 8 | tail -1)"
  preview="${preview##*\*}"
  # shellcheck disable=SC2001
  preview="$(echo "${preview}" | sed -e 's|^[[:space:]]*||')"
fi

source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export DOTNET_ROOT=\"\$HOME/.asdf/installs/dotnet-core/$preview\""
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.bash"
