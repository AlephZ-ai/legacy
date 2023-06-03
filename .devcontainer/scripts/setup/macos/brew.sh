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
  brew install --cask microsoft-openjdk iterm2 microsoft-edge xquartz
# Setup post hombrew packages
  sudo ln -sfn "$HOMEBREW_PREFIX/opt/openjdk/libexec/openjdk.jdk" /Library/Java/JavaVirtualMachines/openjdk.jdk
  sudo ln -sfn "$HOMEBREW_PREFIX/opt/openjdk@8/libexec/openjdk.jdk" /Library/Java/JavaVirtualMachines/openjdk-8.jdk
  sudo ln -sfn "$HOMEBREW_PREFIX/opt/openjdk@11/libexec/openjdk.jdk" /Library/Java/JavaVirtualMachines/openjdk-11.jdk
  sudo ln -sfn "$HOMEBREW_PREFIX/opt/openjdk@17/libexec/openjdk.jdk" /Library/Java/JavaVirtualMachines/openjdk-17.jdk
# Run Homebrew cleanup and doctor to check for errors
  brew cleanup
  brew doctor || true
