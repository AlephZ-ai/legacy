#!/usr/bin/env bash
"$DEVCONTAINER_SCRIPTS_ROOT/utils/brew/uninstall-all-brews.sh"
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
