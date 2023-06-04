#!/usr/bin/env bash
unsafe="$1"
"$DEVCONTAINER_SCRIPTS_ROOT/utils/brew/uninstall.sh"
sudo rm -rf "/Users/$(whoami)/Library/Caches/Homebrew/"
sudo rm -rf "/Users/$(whoami)/Library/Logs/Homebrew/"
sudo rm -rf /usr/local/Caskroom
sudo rm -rf /usr/local/Cellar
sudo rm -rf /usr/local/Homebrew
case "$unsafe" in
 1)
    sudo rm -rf /usr/local/Frameworks
    sudo rm -rf /usr/local/bin
    sudo rm -rf /usr/local/etc
    sudo rm -rf /usr/local/include
    sudo rm -rf /usr/local/lib
    sudo rm -rf /usr/local/opt
    sudo rm -rf /usr/local/sbin
    sudo rm -rf /usr/local/share
    sudo rm -rf /usr/local/var
    ;;
  2)
    sudo rm -rf /usr/local/* &> /dev/null || true
    ;;
esac
