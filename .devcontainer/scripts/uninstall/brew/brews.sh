#!/bin/bash
brew uninstall --force --ignore-dependencies pycairo
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/pip/packages.sh"
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/pip/package-cache.sh"
while [[ $(brew list | wc -l) -ne 0 ]]; do
    for EACH in $(brew list); do
        brew uninstall --force --ignore-dependencies "$EACH"
    done
done
