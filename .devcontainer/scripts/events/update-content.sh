#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
source "$HOME/.zshrc"
rm -f nohup.out
rm -f gcm-diagnose.log
# shellcheck source=/dev/null
source "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup devspace
echo "Press Ctrl+Shift+~ to open a terminal in the current dev container"
