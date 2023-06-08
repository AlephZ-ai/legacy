#!/usr/bin/env zsh
# shellcheck shell=bash
# init
set -euo pipefail
# Adding quantum extension
az extension add --upgrade -n quantum
