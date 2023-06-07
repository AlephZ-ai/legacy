#!/usr/bin/env bash
set -e
"$DEVCONTAINER_SCRIPTS_ROOT/uninstall/dotnet.sh"
for plugin in $(asdf plugin list); do
  for version in $(asdf list "$plugin"); do asdf uninstall "$plugin" "$version"; done
  asdf plugin remove "$plugin"
done
