#!/usr/bin/env bash
"$DEVCONTAINER_SCRIPTS_ROOT/utils/pip/uninstall-all-packages.sh"
"$DEVCONTAINER_SCRIPTS_ROOT/utils/pip/purge-package-cache.sh"
while [[ $(brew list | wc -l) -ne 0 ]]; do
    for EACH in $(brew list); do
        brew uninstall --force --ignore-dependencies "$EACH"
    done
done
