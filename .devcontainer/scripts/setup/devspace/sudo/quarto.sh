#!/usr/bin/env bash
set -euo pipefail
# Setup Quarto
curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb -o /tmp/quarto-linux-amd64.deb
gdebi /tmp/quarto-linux-amd64.deb
rm -rf /tmp/quarto-linux-amd64.deb
