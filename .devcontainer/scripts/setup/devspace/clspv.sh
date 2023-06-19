#!/bin/zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
set -euo pipefail
if [ -e "$HOME/.clspv/build" ]; then export PATH="$HOME/.clspv/build/bin:$PATH"; fi
if command -v clspv >/dev/null 2>&1; then
  export CLSPV_FAST_LEVEL=${CLSPV_FAST_LEVEL:-${FAST_LEVEL:-0}}
else
  export CLSPV_FAST_LEVEL=0
fi

echo "CLSPV_FAST_LEVEL=$CLSPV_FAST_LEVEL"
# Function to clone or update a repo
function clone_or_update_repo() {
  local repo_name="$1"
  local repo_owner="$2"
  local repo_cmd="${3:-}"
  local repo_dir="$HOME/.clspv"

  "$DEVCONTAINER_SCRIPTS_ROOT/utils/clone-or-update-repo.sh" "$repo_name" "$repo_owner" "$repo_dir" "$repo_cmd"
}

if [ "$CLSPV_FAST_LEVEL" -eq 0 ]; then
  clone_or_update_repo clspv google 'python utils/fetch_sources.py; mkdir -p build && pushd build; cmake -G Ninja -DCMAKE_BUILD_TYPE=Release ..; ninja; popd;'
fi

# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'export PATH="$HOME/.clspv/build/bin:$PATH"'
