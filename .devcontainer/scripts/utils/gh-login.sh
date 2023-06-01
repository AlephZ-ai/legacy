#!/usr/bin/env bash
gh auth setup-git
if [[ -z "${GITHUB_TOKEN}" ]] && ! gh auth status; then
    gh auth login
fi

gh config set -h github.com git_protocol https
gh auth status
