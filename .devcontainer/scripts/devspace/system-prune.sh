#!/usr/bin/env bash
set -ex
"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" devspace clean
docker system prune -a -f --volumes
