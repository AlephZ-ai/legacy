#!/usr/bin/env zsh
# shellcheck shell=bash
unsafe="$1"
brew uninstall --force --ignore-dependencies bash
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/brew.sh"
sudo rm -rf "/Users/$(whoami)/Library/Caches/Homebrew/"
sudo rm -rf "/Users/$(whoami)/Library/Logs/Homebrew/"
if [ "$unsafe" -ge 1 ]; then
    sudo rm -rf /usr/local/Frameworks
    sudo rm -rf /usr/local/bin
    sudo rm -rf /usr/local/etc
    sudo rm -rf /usr/local/include
    sudo rm -rf /usr/local/lib
    sudo rm -rf /usr/local/opt
    sudo rm -rf /usr/local/sbin
    sudo rm -rf /usr/local/share
    sudo rm -rf /usr/local/var
fi

if [ "$unsafe" -ge 2 ]; then
    sudo rm -rf /usr/local/* &> /dev/null || true
fi
