#!/usr/bin/env bash
set -e
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/dotnet.sh"
if command -v asdf --version >/dev/null 2>&1; then
  for plugin in $(asdf plugin list); do
    for version in $(asdf list "$plugin"); do asdf uninstall "$plugin" "$version" || true; done
    asdf plugin remove "$plugin"
  done
fi

rm -rf "$HOME/.asdf"
