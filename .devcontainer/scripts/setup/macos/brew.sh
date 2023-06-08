#!/usr/bin/env bash
# init
set -euo pipefail
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
brew reinstall --include-test --force --cask --zap microsoft-openjdk iterm2 microsoft-edge xquartz miniconda anaconda
# Setup post hombrew packages
sudo ln -sfn "$HOMEBREW_PREFIX/opt/openjdk/libexec/openjdk.jdk" /Library/Java/JavaVirtualMachines/openjdk.jdk
sudo ln -sfn "$HOMEBREW_PREFIX/opt/openjdk@8/libexec/openjdk.jdk" /Library/Java/JavaVirtualMachines/openjdk-8.jdk
sudo ln -sfn "$HOMEBREW_PREFIX/opt/openjdk@11/libexec/openjdk.jdk" /Library/Java/JavaVirtualMachines/openjdk-11.jdk
sudo ln -sfn "$HOMEBREW_PREFIX/opt/openjdk@17/libexec/openjdk.jdk" /Library/Java/JavaVirtualMachines/openjdk-17.jdk
# Run Homebrew cleanup and doctor to check for errors
brew cleanup
brew doctor || true
