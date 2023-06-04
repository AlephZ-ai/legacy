#!/usr/bin/env zsh
#shellcheck shell=bash
rm -f nohup.out
rm -f gcm-diagnose.log
if [[ "${CODESPACES}" == "true" ]]; then
  echo "Running in a prebuild or in GitHub Codespaces. Ignore interactive commands."
  # Non-interactive commands...
else
  # Login to GitHub
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/gh-login.sh"
  # Login to Docker
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/docker-login.sh"
fi
echo "Press Ctrl+Shift+~ to open a terminal in the current dev container"
