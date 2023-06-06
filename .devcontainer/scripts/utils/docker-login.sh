# shellcheck shell=bash
set -e
gh auth token | docker login ghcr.io -u TOKEN --password-stdin
