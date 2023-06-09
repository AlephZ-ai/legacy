#!/usr/bin/env bash
# shellcheck source=/dev/null

set -euo pipefail

source dev-container-features-test-lib

check "\$TEST=42" [ "$(source "$HOME/.bashrc" && echo "$TEST")" = "42" ]

reportResults
