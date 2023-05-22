#!/usr/bin/env zsh
#shellcheck shell=bash
set -e
rm -f nohup.out
rm -f gcm-diagnose.log
"$DEVCONTAINER_SCRIPTS_ROOT/run" -s setup devspace 
echo "Press Ctrl+Shift+~ to open a terminal in the current dev container"
