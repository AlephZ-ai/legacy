#!/usr/bin/env bash
set -ex
devcontainer build --workspace-folder "$DEVCONTAINER_FEATURES_PROJECT_ROOT"
