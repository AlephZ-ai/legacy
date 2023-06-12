#!/usr/bin/env bash
set -euo pipefail
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/dotnet.sh"
if [ "$FAST_LEVEL" -eq 0 ] && command -v asdf >/dev/null 2>&1; then
  for plugin in $(asdf plugin list); do
    for version in $(asdf list "$plugin"); do
      version="${version##*( )}"
      version="${version#*\*}"
      version="${version##*( )}"
      asdf uninstall "$plugin" "$version"
    done

    asdf plugin remove "$plugin"
  done
fi

rm -rf "$HOME/.asdf"
