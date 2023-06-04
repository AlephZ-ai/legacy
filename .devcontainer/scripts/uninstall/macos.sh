#!/usr/bin/env zsh
# shellcheck shell=bash
unsafe="$1"
if brew; then
  brew uninstall --force --ignore-dependencies bash
  "$DEVCONTAINER_SCRIPTS_ROOT/uninstall/brew.sh"
fi

sudo rm -rf "/Users/$(whoami)/Library/Caches/Homebrew/"
sudo rm -rf "/Users/$(whoami)/Library/Logs/Homebrew/"
if [ "$unsafe" -ge 1 ]; then
    echo -e "WARNING: You chose at least unsafe level 1. I'm deleting the above directories"
    sudo rm -rf /usr/local/Frameworks
    sudo rm -rf /usr/local/bin &> /dev/null
    sudo rm -rf /usr/local/etc
    sudo rm -rf /usr/local/include
    sudo rm -rf /usr/local/lib &> /dev/null
    sudo rm -rf /usr/local/opt
    sudo rm -rf /usr/local/sbin
    sudo rm -rf /usr/local/share
    sudo rm -rf /usr/local/var
fi

if [ "$unsafe" -ge 2 ]; then
    echo -e "WARNING: You chose at least unsafe level 2. I am deleteing /usr/local/*"
    sudo rm -rf /usr/local/* &> /dev/null || true
fi
