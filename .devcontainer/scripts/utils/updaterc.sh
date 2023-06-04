# shellcheck shell=bash
set -ex
# Splits a string by semicolon
split_string() {
  local string="$1"
  local delimiter="$2"

  while [[ "$string" ]]; do
    echo "${string%%"$delimiter"*}"
    if [[ "$string" == *"$delimiter"* ]]; then
      string="${string#*"${delimiter}"}"
    else
      break
    fi
  done
}

cmd="$1"
option="$2"

# Split the command into an array
set -f # disable glob
# shellcheck disable=SC2086
set -- $cmd      # split on whitespace
cmd_parts=("$@") # assign to array
CMD_FIRST_PART="${cmd_parts[0]}"

rcs=("$HOME/.bashrc" "$HOME/.zshrc")
if [[ "$option" == "sudo" ]]; then
  rcs=("/etc/bash.bashrc" "/etc/zsh/zshrc")
  if [[ $cmd != sudo* ]]; then cmd="sudo $cmd"; fi
else
  IFS=$';' read -ra rcs <<<"$(split_string "$option" ";")"
fi

# Check if the first part of the command is 'sudo'
if [ "$CMD_FIRST_PART" = 'sudo' ]; then
  # If it is, run the command with sudo
  cmd="${cmd_parts[*]:1}"
fi

eval "$cmd" &>/dev/null || true
for rc in "${rcs[@]}"; do
  echo "Updating $rc"
  if [ "$CMD_FIRST_PART" = 'sudo' ]; then
    if ! sudo grep -Fxq "$cmd" "$rc" >/dev/null; then echo -e "$cmd" | sudo tee -a "$rc" >/dev/null; fi
  else
    if ! grep -Fxq "$cmd" "$rc" >/dev/null; then echo -e "$cmd" >>"$rc"; fi
  fi
done
