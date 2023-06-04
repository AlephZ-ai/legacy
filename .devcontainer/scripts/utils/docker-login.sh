# shellcheck shell=bash
set -ex
gh auth token | docker login ghcr.io -u TOKEN --password-stdin
