# shellcheck shell=bash
set -euo pipefail
gh auth token | docker login ghcr.io -u TOKEN --password-stdin
