#!/usr/bin/env bash
# init
set -e
# shellcheck source=/dev/null
source /etc/bash.bashrc
# Update apt-packages
while ! (
  apt update
  apt upgrade -y
  apt install -y --install-recommends --fix-broken --fix-missing
  apt install -y --install-recommends sudo systemd mawk gawk bash zsh file sed curl wget grep bzip2 swig build-essential make cmake gcc g++ less locales
  apt install -y --install-recommends patch tzdata uuid-runtime netbase python3 python3-dev python-openssl dotnet-sdk-6.0 dotnet-sdk-7.0 git apt-transport-https
  apt install -y --install-recommends ca-certificates age openssl openssh-client procps checkinstall dos2unix software-properties-common libnss3 libnss3-tools
  apt install -y --install-recommends shellcheck jq moreutils bash-completion zlib1g-dev speedtest-cli powerline fonts-powerline fonts-dejavu-core gedit gimp
  apt install -y --install-recommends nautilus vlc x11-apps ffmpeg libsndfile1 libasound2 libasound2-dev libasound2-plugins libasound2-data libasound2-doc
  apt install -y --install-recommends sqlite3 libsqlite3-dev libopenmpi-dev libssl-dev libbz2-dev libreadline-dev libncurses5-dev libncursesw5-dev
  apt install -y --install-recommends xz-utils tk-dev libffi-dev liblzma-dev libgl1-mesa-glx libegl1-mesa libxrandr2 libxss1 libxcursor1 libxcomposite1 libxtst6
); do echo "Retrying apt-packages..."; done

libreadline-dev \
  git
