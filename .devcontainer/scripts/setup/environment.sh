# shellcheck shell=bash
# shellcheck source=/dev/null
projectRoot="$(dirname "$(dirname "$(dirname "$(cd -- "$(dirname -- "${BASH_SOURCE-$0}")" &>/dev/null && pwd)")")")"
set -o allexport
source "$projectRoot/.devcontainer/.env"
set +o allexport
export PSHELL="pwsh"
export DEVCONTAINER_FEATURES_PROJECT_ROOT="$projectRoot"
export DEVCONTAINER_FEATURES_SOURCE_ROOT="$DEVCONTAINER_FEATURES_PROJECT_ROOT/src"
export DEVCONTAINER_PROJECT_ROOT="$DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer"
export DEVCONTAINER_SCRIPTS_ROOT="$DEVCONTAINER_PROJECT_ROOT/scripts"
if [ -e /mnt/c ]; then
  export MNT_C=/mnt/c
fi

if [ -e /mnt/wslg ]; then
  export MNT_WSLG=/mnt/wslg
fi

if [ -e /tmp/.X11-unix ]; then
  export X11_SOCKET=/tmp/.X11-unix
fi

if [ -e /usr/lib/wsl ]; then
  export LIB_WSL=/usr/lib/wsl
fi
