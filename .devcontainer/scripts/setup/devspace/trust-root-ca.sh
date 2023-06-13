#!/usr/bin/env zsh
# shellcheck shell=bash
# init
set -euo pipefail
if [ "${FAST_LEVEL:-0}" -le 1 ]; then
  # Make trusted root CA then install and trust it
  dotnet dev-certs https
  mkcert -install
  dotnet dev-certs https --trust
fi
