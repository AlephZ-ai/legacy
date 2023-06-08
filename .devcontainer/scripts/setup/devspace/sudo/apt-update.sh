#!/usr/bin/env bash
# init
set -euo pipefail
# Update apt-packages
apt install -y --install-recommends --fix-broken --fix-missing
apt update
apt upgrade -y