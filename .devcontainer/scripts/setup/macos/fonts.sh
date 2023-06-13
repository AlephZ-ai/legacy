#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
# init
set -euo pipefail
urldecode() {
  if perl -MURI::Escape -e '' &>/dev/null; then
    perl -MURI::Escape -e 'print uri_unescape($ARGV[0])' "$1"
  elif python -c 'import urllib.parse' &>/dev/null; then
    python -c "import urllib.parse; print(urllib.parse.unquote('$1'))"
  else
    # shellcheck disable=SC2059
    printf "$(echo -n $1 | sed 's/+/ /g;s/%\(..\)/\\x\1/g;')"
  fi
}

# create a temporary directory
tmppath="/tmp/MesloLGS_NF"
url="https://github.com/romkatv/powerlevel10k-media/raw/master"
mkdir -p "$tmppath"
# change the working directory to the temporary directory
pushd "$tmppath"
# download the font files
for font in "MesloLGS%20NF%20Regular.ttf" "MesloLGS%20NF%20Bold.ttf" "MesloLGS%20NF%20Italic.ttf" "MesloLGS%20NF%20Bold%20Italic.ttf"; do
  font_url="$url/$font"
  font_file=$(urldecode "$font")
  curl -L "$font_url" -o "$font_file"
done

# install the font files
# shellcheck disable=SC2035
cp *.ttf "$HOME/Library/Fonts/"
popd
# remove the temporary directory
rm -rf "$tmppath"
