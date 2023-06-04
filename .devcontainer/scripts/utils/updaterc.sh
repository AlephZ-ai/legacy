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
  [[ $cmd != sudo* ]] && cmd="sudo $cmd"
else
  arr=()
  while IFS= read -r line; do
    arr+=("$line")
  done < <(split_string "$option" ";") # read output of split_string into array
  rcs=("${arr[@]}")
fi

# Check if the first part of the command is 'sudo'
if [ "$CMD_FIRST_PART" = 'sudo' ]; then
  # If it is, run the command with sudo
  sudo "${cmd_parts[@]:1}"
else
  # If not, run the command as is
  eval "$cmd" &>/dev/null || true
fi

printf 'Updating: %s\n' "${rcs[@]}"
for rc in "${rcs[@]}"; do
  if [ -f "$rc" ]; then
    if ! grep -Fxq "$cmd" "$rc"; then
      sudo echo -e "$cmd" | if [ "$CMD_FIRST_PART" = 'sudo' ]; then sudo tee -a "$rc"; fi >/dev/null
    fi
  else
    echo "File $rc does not exist."
  fi
done
