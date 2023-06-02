#!/usr/bin/env zsh
#shellcheck shell=bash
# init
  set -e
  # shellcheck source=/dev/null
  source "$HOME/.zshrc"
# Repair and Update if needed
  brew update
  brew tap --repair
# Upgrade all packages
  brew update
  brew upgrade
# Upgrade all casks
  brew update --cask
  brew upgrade --cask
# Install xquartz
  brew install --cask microsoft-edge xquartz
# Run Homebrew cleanup and doctor to check for errors
  brew cleanup
  brew doctor || true
