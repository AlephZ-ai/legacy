#!/usr/bin/env bash
# init
  set -e
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
# Docker login
  echo "$GITHUB_TOKEN" | docker login ghcr.io -u TOKEN --password-stdin
