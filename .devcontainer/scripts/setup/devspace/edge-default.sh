#!/usr/bin/env bash
# init
set -ex
# shellcheck source=/dev/null
source "$HOME/.bashrc"
os=$(uname -s)
# Make Edge the default browser if installed
if [ "$os" == "Linux" ]; then
  browser='/usr/bin/microsoft-edge-stable'
  cmds=("alias xdg-open=$browser" "export BROWSER=$browser")
  # shellcheck disable=SC2068
  for i in ${!cmds[@]}; do
    cmd="${cmds[$i]}"
    # shellcheck source=/dev/null
    source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "$cmd"
  done
fi
