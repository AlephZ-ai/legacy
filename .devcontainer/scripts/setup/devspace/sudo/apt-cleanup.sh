#!/usr/bin/env bash
# init
set -euo pipefail
# Cleanup apt-packages
apt autoclean -y
apt autoremove -y
