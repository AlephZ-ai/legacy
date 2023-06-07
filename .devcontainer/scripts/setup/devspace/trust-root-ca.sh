#!/usr/bin/env bash
# shellcheck shell=bash
# init
set -e
# shellcheck source=/dev/null
source "$HOME/.bashrc"
# Make trusted root CA then install and trust it
mkcert -install
dotnet dev-certs https --trust
