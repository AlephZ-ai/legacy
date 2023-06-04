#!/usr/bin/env bash
#shellcheck source=/dev/null

set -ex

source dev-container-features-test-lib


check "\$TEST=43" [ "$(source /etc/environment && echo "$TEST")" == "43" ]


reportResults
