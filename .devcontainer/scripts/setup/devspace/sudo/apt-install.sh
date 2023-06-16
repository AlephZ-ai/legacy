#!/usr/bin/env bash
# init
set -euo pipefail
echo "Adding non-free packages..."
# Bring in ID, ID_LIKE, VERSION_ID, VERSION_CODENAME
# shellcheck disable=SC1091
source /etc/os-release
# Needed for adding manpages-posix and manpages-posix-dev which are non-free packages in Debian
# Bring in variables from /etc/os-release like VERSION_CODENAME
sed -i -E "s/deb http:\/\/(deb|httpredir)\.debian\.org\/debian ${VERSION_CODENAME} main/deb http:\/\/\1\.debian\.org\/debian ${VERSION_CODENAME} main contrib non-free/" /etc/apt/sources.list
sed -i -E "s/deb-src http:\/\/(deb|httredir)\.debian\.org\/debian ${VERSION_CODENAME} main/deb http:\/\/\1\.debian\.org\/debian ${VERSION_CODENAME} main contrib non-free/" /etc/apt/sources.list
sed -i -E "s/deb http:\/\/(deb|httpredir)\.debian\.org\/debian ${VERSION_CODENAME}-updates main/deb http:\/\/\1\.debian\.org\/debian ${VERSION_CODENAME}-updates main contrib non-free/" /etc/apt/sources.list
sed -i -E "s/deb-src http:\/\/(deb|httpredir)\.debian\.org\/debian ${VERSION_CODENAME}-updates main/deb http:\/\/\1\.debian\.org\/debian ${VERSION_CODENAME}-updates main contrib non-free/" /etc/apt/sources.list
sed -i "s/deb http:\/\/security\.debian\.org\/debian-security ${VERSION_CODENAME}\/updates main/deb http:\/\/security\.debian\.org\/debian-security ${VERSION_CODENAME}\/updates main contrib non-free/" /etc/apt/sources.list
sed -i "s/deb-src http:\/\/security\.debian\.org\/debian-security ${VERSION_CODENAME}\/updates main/deb http:\/\/security\.debian\.org\/debian-security ${VERSION_CODENAME}\/updates main contrib non-free/" /etc/apt/sources.list
sed -i "s/deb http:\/\/deb\.debian\.org\/debian ${VERSION_CODENAME}-backports main/deb http:\/\/deb\.debian\.org\/debian ${VERSION_CODENAME}-backports main contrib non-free/" /etc/apt/sources.list
sed -i "s/deb-src http:\/\/deb\.debian\.org\/debian ${VERSION_CODENAME}-backports main/deb http:\/\/deb\.debian\.org\/debian ${VERSION_CODENAME}-backports main contrib non-free/" /etc/apt/sources.list
# Handle bullseye location for security https://www.debian.org/releases/bullseye/amd64/release-notes/ch-information.en.html
sed -i "s/deb http:\/\/security\.debian\.org\/debian-security ${VERSION_CODENAME}-security main/deb http:\/\/security\.debian\.org\/debian-security ${VERSION_CODENAME}-security main contrib non-free/" /etc/apt/sources.list
sed -i "s/deb-src http:\/\/security\.debian\.org\/debian-security ${VERSION_CODENAME}-security main/deb http:\/\/security\.debian\.org\/debian-security ${VERSION_CODENAME}-security main contrib non-free/" /etc/apt/sources.list

# Update apt-packages
echo "Running apt-get update..."
while ! (
  apt update
  apt upgrade -y
  apt install -y --install-recommends --fix-broken --fix-missing
  apt install -y --install-recommends sudo systemd mawk gawk bash zsh file sed curl wget grep bzip2 swig build-essential make cmake ninja-build gcc g++ less locales apt-transport-https
  apt install -y --install-recommends patch tzdata uuid-runtime netbase python3 python3-dev python3-openssl python3-opencv python3-numpy dotnet-sdk-6.0 dotnet-sdk-7.0 git
  apt install -y --install-recommends ca-certificates age openssl openssh-client procps checkinstall dos2unix software-properties-common libnss3 libnss3-tools
  apt install -y --install-recommends shellcheck jq moreutils bash-completion zlib1g-dev speedtest-cli powerline fonts-powerline fonts-dejavu-core gedit gimp
  apt install -y --install-recommends nautilus vlc x11-apps ffmpeg libsndfile1 libasound2 libasound2-dev libasound2-plugins libasound2-data libasound2-doc
  apt install -y --install-recommends gnupg sqlite3 libsqlite3-dev libopenmpi-dev libssl-dev libbz2-dev libreadline-dev libncurses5-dev libncursesw5-dev
  apt install -y --install-recommends xz-utils tk-dev libffi-dev liblzma-dev libgl1-mesa-glx libegl1-mesa libxrandr2 libxss1 libxcursor1 libxcomposite1 libxtst6
  apt install -y --install-recommends libatlas-base-dev libopenblas-dev libblas-dev liblapack-dev liblapacke-dev liblapack-doc liblapack-pic liblapacke liblapacke-dev
  apt install -y --install-recommends caffe-cuda caffe-tools-cuda caffe-cuda-cublas caffe-cuda-cublas-dev caffe-cuda-cudart caffe-cuda-cudart-dev
  apt install -y --install-recommends caffe-cuda-cufft caffe-cuda-cufft-dev caffe-cuda-curand caffe-cuda-curand-dev caffe-cuda-cusolver caffe-cuda-cusolver-dev
  apt install -y --install-recommends caffe-cuda-cusparse caffe-cuda-cusparse-dev caffe-cuda-npp caffe-cuda-npp-dev caffe-cuda-nvrtc caffe-cuda-nvrtc-dev
  apt install -y --install-recommends caffe-cuda-cudnn caffe-cuda-cudnn-dev caffe-cuda-cudnn8 caffe-cuda-cudnn8-dev caffe-cuda-cudnn8-doc caffe-cuda-cudnn8-samples
  apt install -y --install-recommends libusb-dev libgtk-3-dev libpng-dev libjpeg-dev libopenexr-dev libtiff-dev libwebp-dev libavcodec-dev libavformat-dev libswscale-dev libuv-dev libuv1-dev
  apt install -y --install-recommends manpages-posix manpages-posix-dev bats clang lld ccache libgomp1 libomp-dev neovim
); do echo "Retrying apt-packages..."; done
