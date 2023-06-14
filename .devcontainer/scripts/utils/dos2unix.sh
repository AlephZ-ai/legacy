# shellcheck shell=bash
set -euo pipefail
dos2unix "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run"
dos2unix "$DEVCONTAINER_PROJECT_ROOT/init"
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT" -type f -iname "*.sh" -exec dos2unix "{}" \;
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT" -type f -iname "*.ps1" -exec dos2unix "{}" \;
