#!/usr/bin/env bash
#shellcheck disable=SC2016
#shellcheck source=/dev/null

set -e

source dev-container-features-test-lib


check "echo \$HELLO" [ "$(source /etc/environment && echo "$HELLO")" == "5" ]
user="$(whoami)"
source "$HOME/.bashrc"
check "$CURRENT_USER" [ "$CURRENT_USER" == "$user" ]


reportResults