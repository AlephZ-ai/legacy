#!/usr/bin/env bash

USERNAME="$1"
USER_UID="$2"
USER_GID="$3"

if id "$USERNAME"; then 
  groupmod --gid "$USER_GID" "$USERNAME"
  usermod --uid "$USER_UID" --gid "$USER_GID" "$USERNAME"
  chown -R "$USER_UID":"$USER_GID" "/home/$USERNAME"
else
  echo "Creating user $USERNAME"
  groupadd --gid "$USER_GID" "$USERNAME"
  useradd --uid "$USER_UID" --gid "$USER_GID" -m "$USERNAME"
  apt-get update
  apt-get install -y sudo
  line="$USERNAME ALL=\(root\) NOPASSWD:ALL"
  file="/etc/sudoers.d/$USERNAME"
  grep -qxF "$line" "$file" || echo "$line" >> "$file"
  chmod 0440 "/etc/sudoers.d/$USERNAME"
fi
