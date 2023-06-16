# shellcheck shell=bash
# init
set -euo pipefail
echo -e "--- file: $LEGACY_PROJECT_ROOT/run ---"
cat "$LEGACY_PROJECT_ROOT/run"
echo -e "--- file: $DEVCONTAINER_PROJECT_ROOT/init ---"
cat "$DEVCONTAINER_PROJECT_ROOT/init"

find "$DEVCONTAINER_PROJECT_ROOT/scripts" -type f -iname "*.sh" -exec bash -c 'echo -e "--- file: $1 ---"; cat "$1"' _ {} \;
find "$LEGACY_PROJECT_ROOT/src" -type f -iname "*.sh" -exec bash -c 'echo -e "--- file: $1 ---"; cat "$1"' _ {} \;
find "$LEGACY_PROJECT_ROOT/test" -type f -iname "*.sh" -exec bash -c 'echo -e "--- file: $1 ---"; cat "$1"' _ {} \;
