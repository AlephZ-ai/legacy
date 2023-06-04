# shellcheck shell=bash
gh auth token | docker login ghcr.io -u TOKEN --password-stdin
