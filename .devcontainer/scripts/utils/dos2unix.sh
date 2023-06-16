# shellcheck shell=bash
set -euo pipefail
dos2unix "$LEGACY_PROJECT_ROOT/run"
dos2unix "$DEVCONTAINER_PROJECT_ROOT/init"
find "$LEGACY_PROJECT_ROOT" -type f -iname "*.sh" -exec dos2unix "{}" \;
find "$LEGACY_PROJECT_ROOT" -type f -iname "*.ps1" -exec dos2unix "{}" \;
