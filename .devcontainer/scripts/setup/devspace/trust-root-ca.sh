#!/usr/bin/env zsh
# shellcheck shell=bash
# init
set -euo pipefail
if [ "${FAST_LEVEL:-0}" -le 1 ]; then
  # Make trusted root CA then install and trust it
  if command -v dotnet >/dev/null 2>&1; then dotnet dev-certs https; fi
  mkcert -install
  if command -v dotnet >/dev/null 2>&1; then dotnet dev-certs https --trust; fi
fi
