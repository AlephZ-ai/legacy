#!/usr/bin/env pwsh
gh auth token | docker login ghcr.io -u TOKEN --password-stdin
