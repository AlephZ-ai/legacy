# shellcheck shell=bash
# init
set -euo pipefail
echo -e "--- file: $DEVCONTAINER_FEATURES_PROJECT_ROOT/run ---"
cat "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run"
echo -e "--- file: $DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer/init ---"
cat "$DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer/init"

find "$DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer/scripts" -type f -iname "*.sh" -exec bash -c 'echo -e "--- file: $1 ---"; cat "$1"' _ {} \;
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT/src" -type f -iname "*.sh" -exec bash -c 'echo -e "--- file: $1 ---"; cat "$1"' _ {} \;
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT/test" -type f -iname "*.sh" -exec bash -c 'echo -e "--- file: $1 ---"; cat "$1"' _ {} \;
