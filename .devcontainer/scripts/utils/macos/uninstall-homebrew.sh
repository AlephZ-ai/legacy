#!/usr/bin/env bash
"$DEVCONTAINER_SCRIPTS_ROOT/utils/brew/uninstall.sh"
sudo rm -rf "/Users/$(whoami)/Library/Caches/Homebrew/"
sudo rm -rf "/Users/$(whoami)/Library/Logs/Homebrew/"
sudo rm -rf /usr/local/Caskroom
sudo rm -rf /usr/local/Cellar
sudo rm -rf /usr/local/Frameworks
sudo rm -rf /usr/local/Homebrew
sudo rm -rf /usr/local/bin
sudo rm -rf /usr/local/etc
sudo rm -rf /usr/local/include
sudo rm -rf /usr/local/lib
sudo rm -rf /usr/local/opt
sudo rm -rf /usr/local/sbin
sudo rm -rf /usr/local/share
sudo rm -rf /usr/local/var
# sudo rm -rf /usr/local/* &> /dev/null || true
