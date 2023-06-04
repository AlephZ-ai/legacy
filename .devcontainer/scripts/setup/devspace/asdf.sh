#!/usr/bin/env bash
# init
set -ex
# shellcheck source=/dev/null
source "$HOME/.bashrc"
# Setup asdf
set -ex
asdf plugin-add dotnet-core https://github.com/emersonsoares/asdf-dotnet-core.git || true
set -ex
asdf plugin update --all
preview="$(asdf list all dotnet-core 8)"
current="$(asdf list all dotnet-core 7)"
lts="$(asdf list all dotnet-core 6)"
asdf install dotnet-core "$preview"
asdf install dotnet-core "$current"
asdf install dotnet-core "$lts"
asdf global dotnet-core "$preview"
asdf reshim
asdf info
