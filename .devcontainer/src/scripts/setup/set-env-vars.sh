#!/usr/bin/env zsh
#shellcheck shell=bash
#shellcheck source=/dev/null
projectRoot="$(dirname "$(dirname "$(dirname "$(dirname "$(cd -- "$(dirname -- "${BASH_SOURCE-$0}")" &> /dev/null && pwd)")")")")"
set -o allexport
source "$projectRoot/.env"
set +o allexport
export PSHELL="pwsh"
export DEVCONTAINER_FEATURES_PROJECT_ROOT="$projectRoot"
export DEVCONTAINER_FEATURES_SOURCE_ROOT="$DEVCONTAINER_FEATURES_PROJECT_ROOT/src"
export DEVCONTAINER_FEATURES_SCRIPTS_ROOT="$DEVCONTAINER_FEATURES_SOURCE_ROOT/scripts"
export DEVCONTAINER_FEATURES_DEVCONTAINER_ROOT="$DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer"
export DEVCONTAINER_FEATURES_DEVCONTAINER_SOURCE_ROOT="$DEVCONTAINER_FEATURES_DEVCONTAINER_ROOT/src"
export DEVCONTAINER_FEATURES_DEVCONTAINER_SCRIPTS_ROOT="$DEVCONTAINER_FEATURES_DEVCONTAINER_SOURCE_ROOT/scripts"