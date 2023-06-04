#!/usr/bin/env bash
# init
set -ex
# desktop-lite fix for versions > 1.2.0
# Find the version number by looking at the directory names
NOVNC_VERSION=$(basename "$(find /usr/local/novnc -type d -name 'noVNC-*' | head -n 1)") || true

# Check if NOVNC_VERSION is not null
if [[ -n "${NOVNC_VERSION}" ]]; then
  # Construct the paths
  NOVNC_UTILS_PATH="/usr/local/novnc/${NOVNC_VERSION}/utils"
  LAUNCH_SCRIPT="${NOVNC_UTILS_PATH}/launch.sh"
  # Create the launch.sh script if it doesn't exist
  if [ ! -f "$LAUNCH_SCRIPT" ]; then
      echo "${NOVNC_UTILS_PATH}/novnc_proxy \"\$@\"" | sudo tee "$LAUNCH_SCRIPT"
      sudo chmod +x "$LAUNCH_SCRIPT"
  else
      echo "File $LAUNCH_SCRIPT already exists."
  fi
else
  echo "NOVNC_VERSION is null. Exiting."
fi
