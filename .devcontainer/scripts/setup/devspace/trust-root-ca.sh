#!/usr/bin/env zsh
# shellcheck shell=bash
set -euo pipefail
# Make trusted root CA then install and trust it
if command -v dotnet >/dev/null 2>&1; then dotnet dev-certs https; fi
mkcert -install
if command -v dotnet >/dev/null 2>&1; then dotnet dev-certs https --trust; fi
