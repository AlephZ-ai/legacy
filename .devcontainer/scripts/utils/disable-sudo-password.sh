# shellcheck shell=bash
# init
set -ex
USERNAME=${USERNAME:-$(whoami)}
echo $USERNAME
# Disable needing password for sudo
# shellcheck source=/dev/null
file="/etc/sudoers.d/$USERNAME"
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "sudo $USERNAME ALL=(ALL:ALL) NOPASSWD: ALL" "$file"
if [ -f "/etc/sudoers.d/$USERNAME" ]; then
  sudo chmod 440 "/etc/sudoers.d/$USERNAME"
fi
