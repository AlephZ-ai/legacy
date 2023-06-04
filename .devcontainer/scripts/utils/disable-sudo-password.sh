# shellcheck shell=bash
# init
set -ex
USERNAME=${USERNAME:-$(whoami)}
# Disable needing password for sudo
# shellcheck source=/dev/null
file="/etc/sudoers.d/$USERNAME"
# shellcheck source=/dev/null
"$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "sudo $USERNAME ALL=(ALL:ALL) NOPASSWD: ALL" "$file"
sudo chmod 440 "$file"
