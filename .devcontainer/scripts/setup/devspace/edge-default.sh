#!/usr/bin/env zsh
# shellcheck shell=bash
# init
set -euo pipefail
os=$(uname -s)
# Make Edge the default browser if installed
if [ "$os" = "Linux" ]; then
  browser='/usr/bin/microsoft-edge-stable'
  cmds=("alias xdg-open=$browser" "export BROWSER=$browser")
  for i in "${!cmds[@]}"; do
    cmd="${cmds[$i]}"
    # shellcheck source=/dev/null
    source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "$cmd"
  done
fi
