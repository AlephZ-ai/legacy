#!/usr/bin/env bash
gh config set -h github.com git_protocol https
gh auth setup-git
if ! gh auth status; then
  if ! gh auth status && [[ -n "${GITHUB_TOKEN}" ]]; then
    echo "${GITHUB_TOKEN}" | gh auth login --with-token
  fi
fi

if ! gh auth status; then gh auth login; fi
gh auth status
