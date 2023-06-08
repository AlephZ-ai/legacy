#!/usr/bin/env zsh
# shellcheck shell=bash
rm -f nohup.out
rm -f gcm-diagnose.log
if [[ $- = *i* ]]; then
  # Interactive commands...
  # Login to GitHub
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/gh-login.sh"
  # Login to Docker
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/docker-login.sh"
else
  # Non-interactive commands...
  echo "Running in a prebuild. Ignore interactive commands."
fi

echo "Press Ctrl+Shift+~ to open a terminal in the current dev container"
