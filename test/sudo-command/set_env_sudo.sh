#!/usr/bin/env bash
# shellcheck source=/dev/null

set -euo pipefail

source dev-container-features-test-lib

check "\$TEST=43" [ "$(source /etc/environment && echo "$TEST")" == "43" ]

reportResults
