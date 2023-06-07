#!/usr/bin/env bash
set -e
dotnet tool list -g | awk 'NR>2 {print $1}' | xargs -I {} -n1 dotnet tool uninstall -g "{}"
rm -rf "$HOME/.dotnet"
