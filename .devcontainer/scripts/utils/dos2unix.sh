# shellcheck shell=bash
set -ex
dos2unix "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" || true
dos2unix "$DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer/init" || true
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer/scripts" -type f -iname "*.sh" -exec dos2unix "{}" \; || true
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT/src" -type f -iname "*.sh" -exec dos2unix "{}" \; || true
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT/test" -type f -iname "*.sh" -exec dos2unix "{}" \; || true
