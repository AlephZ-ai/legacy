#!/usr/bin/env bats

@test "macos.sh should exit with zero status" {
    run "$DEVCONTAINER_PROJECT_NAME/run" utils chmod-plus-x
    [ "$status" -eq 0 ]
}
