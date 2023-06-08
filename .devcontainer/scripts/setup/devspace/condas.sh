#!/usr/bin/env zsh
# shellcheck shell=bash
# init
set -euo pipefail
os=$(uname -s)
if [ "$os" = "Linux" ]; then
  # Install Miniconda
  MINICONDA_VERSION=$(wget -qO- https://repo.anaconda.com/miniconda/ | grep -oP 'Miniconda3[^"]*Linux-x86_64.sh' | sort -V | tail -n 1)
  MINICONDA_INSTALLER_LINK="https://repo.anaconda.com/miniconda/$MINICONDA_VERSION"
  echo "Installing $MINICONDA_INSTALLER_LINK"
  bash -c "$(curl -fsSL $MINICONDA_INSTALLER_LINK)"

  # Install Anaconda
  ANACONDA_VERSION=$(wget -qO- https://repo.anaconda.com/archive/ | grep -oP 'Anaconda3[^"]*Linux-x86_64.sh' | sort -V | tail -n 1)
  ANACONDA_INSTALLER_LINK="https://repo.anaconda.com/archive/$ANACONDA_VERSION"
  echo "Installing $ANACONDA_INSTALLER_LINK"
  bash -c "$(curl -fsSL $ANACONDA_INSTALLER_LINK)"
fi
