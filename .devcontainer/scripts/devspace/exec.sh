#!/usr/bin/env bash
set -euo pipefail
commandPath="$1"
command="$2"
"$LEGACY_PROJECT_ROOT/run" devspace up
containerid=$(docker ps -q -f name="$DEVCONTAINER_PROJECT_NAME-devspace")
devcontainer exec --container-id "$containerid" zsh -l -c "\$LEGACY_PROJECT_ROOT/run $commandPath $command"
