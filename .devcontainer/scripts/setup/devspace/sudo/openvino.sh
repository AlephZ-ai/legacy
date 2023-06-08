#!/usr/bin/env bash
# init
set -euo pipefail
# Install Microsoft Edge
wget -O /tmp/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
sudo apt-key add /tmp/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
rm -rf /tmp/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
echo "deb https://apt.repos.intel.com/openvino/2023 focal main" | sudo tee /etc/apt/sources.list.d/intel-openvino-2023.list
apt install -y --install-recommends openvino openvino-opencv
apt update
# TODO Finish setup
# https://pypi.org/project/openvino-dev/
# https://docs.openvino.ai/2022.1/openvino_docs_install_guides_installing_openvino_apt.html
