# shellcheck shell=bash
set -ex
# Splits a string by semicolon
split_string() {
  IFS=';' read -r -a arr <<<"$1"
  echo -e "${arr[@]}"
}

cmd="$1"
option="$2"

# Split the command into an array
IFS=' ' read -r -a cmd_parts <<<"$cmd"

# Store the first part of the command in an environment variable
CMD_FIRST_PART="${cmd_parts[0]}"

if [[ "$option" == "sudo" ]]; then
  rcs=("/etc/bash.bashrc" "/etc/zsh/zshrc")
  [[ $cmd != sudo* ]] && cmd="sudo $cmd"
elif [[ -z "$option" ]]; then
  rcs=("$HOME/.bashrc" "$HOME/.zshrc")
else
  IFS=';' read -r -a rcs <<<"$(split_string "$option")"
fi

# Check if the first part of the command is 'sudo'
if [ "$CMD_FIRST_PART" = 'sudo' ]; then
  # If it is, run the command with sudo
  sudo "${cmd_parts[@]:1}"
else
  # If not, run the command as is
  eval "$cmd"
fi

printf 'Updating: %s\n' "${rcs[@]}"
for rc in "${rcs[@]}"; do
  if [[ "$(cat "$rc")" != *"$cmd"* ]]; then
    # Check again if the original command starts with sudo
    if [ "$CMD_FIRST_PART" = 'sudo' ]; then
      # If it is, append the command to the file with sudo
      echo -e "$cmd" | sudo tee -a "$rc" >/dev/null
    else
      # If not, append the command to the file normally
      echo -e "$cmd" >>"$rc"
    fi
  fi
done
