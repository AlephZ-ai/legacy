# shellcheck shell=bash
# init
set -ex
USERNAME=${USERNAME:-$(whoami)}
# Disable needing password for sudo
line="$USERNAME ALL=(ALL:ALL) NOPASSWD: ALL"
file="/etc/sudoers.d/$USERNAME"
sudo grep -qxF "$line" "$file" &>/dev/null || echo -e "$line" | sudo tee -a "$file" &>/dev/null
sudo chmod 440 "$file"
