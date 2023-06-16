#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
set -euo pipefail
if [ -e "$HOME/.emsdk/emsdk_env.sh" ]; then source "$HOME/.emsdk/emsdk_env.sh"; fi
if command -v rustup >/dev/null 2>&1; then
  export EMSDK_FAST_LEVEL=${EMSDK_FAST_LEVEL:-${FAST_LEVEL:-0}}
else
  export EMSDK_FAST_LEVEL=0
fi

echo "EMSDK_FAST_LEVEL=$EMSDK_FAST_LEVEL"
# Function to clone or update a repo
function clone_or_update_repo() {
  local repo_name="$1"
  local repo_owner="$2"
  local repo_cmd="${3:-}"
  local repo_dir="$HOME/.emsdk/repos/$repo_name"

  "$DEVCONTAINER_SCRIPTS_ROOT/utils/clone-or-update-repo.sh" "$repo_name" "$repo_owner" "$repo_dir" "$repo_cmd"
}

clone_or_update_repo emsdk emscripten-core './emsdk install latest; ./emsdk activate latest;'
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'source "$HOME/.emsdk/emsdk_env.sh"'
