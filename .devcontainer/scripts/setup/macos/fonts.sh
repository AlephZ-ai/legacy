#!/usr/bin/env bash
# shellcheck source=/dev/null
# init
set -euo pipefail
# create a temporary directory
tmppath="/tmp/MesloLGS_NF"
url="https://github.com/romkatv/powerlevel10k-media/raw/master"
mkdir -p "$tmppath"
# change the working directory to the temporary directory
pushd "$tmppath"
# download the font files
curl -LO "$url/MesloLGS%20NF%20Regular.ttf"
curl -LO "$url/MesloLGS%20NF%20Bold.ttf"
curl -LO "$url/MesloLGS%20NF%20Italic.ttf"
curl -LO "$url/MesloLGS%20NF%20Bold%20Italic.ttf"
# install the font files
# shellcheck disable=SC2035
cp "*.ttf" "$HOME/Library/Fonts/"
chmod 700 -R "$HOME/Library/Fonts"
popd
# remove the temporary directory
rm -rf "$tmppath"
