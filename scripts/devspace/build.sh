#!/usr/bin/env bash
#shellcheck shell=bash
set -e
devcontainer build --workspace-folder "$DEVCONTAINER_FEATURES_PROJECT_ROOT"
