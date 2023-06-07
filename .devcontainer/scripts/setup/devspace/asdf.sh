#!/usr/bin/env bash
# shellcheck shell=bash
# init
set -e
# shellcheck source=/dev/null
source "$HOME/.bashrc"
# Setup asdf
asdf plugin list | grep -q dotnet-core || asdf plugin add dotnet-core https://github.com/emersonsoares/asdf-dotnet-core.git
asdf plugin update --all
preview="$(asdf list all dotnet-core 8 | tail -1)"
current="$(asdf list all dotnet-core 7 | tail -1)"
lts="$(asdf list all dotnet-core 6 | tail -1)"
versions=("$preview" "$current" "$lts" "$preview")
# shellcheck disable=SC2143
for version in "${versions[@]}"; do
  asdf install dotnet-core "$version"
  asdf global dotnet-core "$preview"
  asdf reshim
  dotnet --version
  asdf info
done
