#!/usr/bin/env zsh
# shellcheck shell=bash
# init
set -e
# shellcheck source=/dev/null
# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'export PATH="/usr/local/opt/openjdk/bin:$PATH"'
