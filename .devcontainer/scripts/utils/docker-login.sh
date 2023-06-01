#!/usr/bin/env bash
gh auth token | docker login ghcr.io -u TOKEN --password-stdin
