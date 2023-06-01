#!/usr/bin/env bash
if [[ -z "${GITHUB_TOKEN}" ]] && ! gh auth status; then
    gh auth login
    gh auth setup-git
    gh config set -h github.com git_protocol https
fi

gh auth status
