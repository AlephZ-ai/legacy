#!/usr/bin/env bash
set -euo pipefail
os=$(uname -s)
sudo rm -rf "$(mkcert -CAROOT)"
if [ "$os" = "Linux" ]; then
  sudo rm -rf "$HOMEBREW_PREFIX/share/ca-certificates/mkcert_rootCA.pem"
  sudo update-ca-certificates
else
  sudo security delete-certificate -c "$(mkcert -CAROOT)"
fi
