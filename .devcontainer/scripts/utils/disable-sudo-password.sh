# shellcheck shell=bash
# init
# shellcheck source=/dev/null
set -euo pipefail
USERNAME=${USERNAME:-$(whoami)}
# Disable needing password for sudo
file="/etc/sudoers.d/$USERNAME"
"$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "sudo $USERNAME ALL=(ALL:ALL) NOPASSWD: ALL" "$file"
sudo chmod 440 "$file"
