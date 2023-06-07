#!/usr/bin/env bash
# shellcheck shell=bash
# init
set -e
# shellcheck source=/dev/null
source "$HOME/.bashrc"
os=$(uname -s)
if [ "$os" = "Linux" ]; then
  # Install Miniconda
  # TODO: Get Latest
  bash -c "$(curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-py310_23.3.1-0-Linux-x86_64.sh)"
  # Install Anaconda
  # TODO: Get Latest
  bash -c "$(curl -fsSL https://repo.anaconda.com/archive/Anaconda3-2023.03-1-Linux-x86_64.sh)"
fi
