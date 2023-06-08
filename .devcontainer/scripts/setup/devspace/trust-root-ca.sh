#!/usr/bin/env zsh
# shellcheck shell=bash
# init
set -e
# Make trusted root CA then install and trust it
mkcert -install
dotnet dev-certs https --trust
