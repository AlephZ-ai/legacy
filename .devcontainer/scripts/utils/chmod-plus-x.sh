# shellcheck shell=bash
set -euo pipefail
git update-index --add --chmod=+x "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run"
chmod +x "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run"
git update-index --add --chmod=+x "$DEVCONTAINER_PROJECT_ROOT/init"
chmod +x "$DEVCONTAINER_PROJECT_ROOT/init"
find "$DEVCONTAINER_PROJECT_ROOT/scripts" -type f -iname "*.sh" -exec git update-index --add --chmod=+x "{}" \;
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT/src" -type f -iname "*.sh" -exec git update-index --add --chmod=+x "{}" \;
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT/test" -type f -iname "*.sh" -exec git update-index --add --chmod=+x "{}" \;
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT" -type f -iname "*.sh" -exec chmod +x "{}" \;
