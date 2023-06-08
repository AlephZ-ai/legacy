#!/usr/bin/env bash
set -euo pipefail
devcontainer build --workspace-folder "$DEVCONTAINER_FEATURES_PROJECT_ROOT"
