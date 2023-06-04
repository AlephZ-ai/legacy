#!/usr/bin/env bash
# init
  set -ex
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
# Adding GH .ssh known hosts
  mkdir -p "$HOME/.ssh/"
  touch "$HOME/.ssh/known_hosts"
  bash -c eval "$(ssh-keyscan github.com >> "$HOME/.ssh/known_hosts")"
# Configure GH
  gh config set -h github.com git_protocol https
