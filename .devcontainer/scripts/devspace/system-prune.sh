#!/usr/bin/env bash
set -euo pipefail
"$LEGACY_PROJECT_ROOT/run" devspace clean
docker system prune -a -f --volumes
