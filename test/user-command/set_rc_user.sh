#!/usr/bin/env bash
#shellcheck disable=SC2016
#shellcheck source=/dev/null

set -e

source dev-container-features-test-lib

user="$(whoami)"
check "$CURRENT_USER" [ "$CURRENT_USER" == "$user" ]

reportResults