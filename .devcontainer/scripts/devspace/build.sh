#!/usr/bin/env bash
set -euo pipefail
devcontainer build --workspace-folder "$LEGACY_PROJECT_ROOT"
