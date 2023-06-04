#!/usr/bin/env bash
# init
  set -ex
  # shellcheck source=/dev/null
  source /etc/bash.bashrc
# Cleanup apt-packages
  apt autoclean -y
  apt autoremove -y
