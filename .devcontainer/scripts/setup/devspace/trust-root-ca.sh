#!/usr/bin/env bash
# init
  set -ex
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
# Make trusted root CA then install and trust it
  mkcert -install
  dotnet dev-certs https --trust
