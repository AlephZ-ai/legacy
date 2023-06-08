# shellcheck shell=bash
set -euo pipefailuo pipefail
gh auth token | docker login ghcr.io -u TOKEN --password-stdin
