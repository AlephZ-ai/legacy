#!/usr/bin/env bash
set -euo pipefail
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/dotnet.sh"
if command -v asdf --version >/dev/null 2>&1; then
  for plugin in $(asdf plugin list); do
    for version in $(asdf list "$plugin"); do
      version="${version#\*}"
      asdf uninstall "$plugin" "$version"
    done

    asdf plugin remove "$plugin"
  done
fi

rm -rf "$HOME/.asdf"
