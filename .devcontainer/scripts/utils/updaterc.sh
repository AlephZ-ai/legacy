# shellcheck shell=bash
# shellcheck source=/dev/null
# init
set -euo pipefail
user_files="$HOME/.bashrc;$HOME/.zshrc"
sudo_files="/etc/bash.bashrc;/etc/zsh/zshrc"
delimiters=('/' '#' '@' '%' '_' '+' '-' ',')
toarray() {
  local resultvar="$1"
  local input="$2"
  local delim="${3:-;}"
  local array=()
  if [[ -n "${ZSH_VERSION:-}" ]]; then
    # shellcheck disable=SC2016
    IFS="$delim" read -rA array <<<"$input"
  else
    # shellcheck disable=SC2016,SC2034
    IFS="$delim" read -ra array <<<"$input"
  fi

  eval "$resultvar=(\"\${array[@]}\")"
}

seddelim() {
  local prefix="$1"
  local cmd="$2"
  # Select a delimiter not present in either $cmd or $prefix
  local delim
  for d in "${delimiters[@]}"; do
    if [[ "$prefix" != *$d* && "$cmd" != *$d* ]]; then
      delim=$d
      break
    fi
  done

  if [ -z "$delim" ]; then
    echo "No delimiter found for prefix: '$prefix'; cmd: '$cmd'"
    exit 1
  fi

  echo "$delim"
}

updaterc() {
  local cmd="$1"
  local rc="$2"
  local sudo="${3:-false}"
  local prefix="${cmd%%=*}="
  # Extract the variable name from the prefix
  # shellcheck disable=SC2155
  local var=$(echo "$prefix" | cut -d'=' -f1 | awk '{print $NF}')
  # Define run function based on sudo status
  run() { if "$sudo"; then sudo "$@"; else "$@"; fi; }
  # shellcheck disable=SC2155
  local rc_dir="$(dirname "$rc")"
  # Check if the exact command already exists in the rc file
  # shellcheck disable=SC2155
  local cmd_exists=$(run grep -Fxq "$cmd" "$rc" >/dev/null && echo true || echo false)
  # Check if the prefix already exists in the rc file
  # shellcheck disable=SC2155
  local prefix_exists=$(run grep -Eq "^$prefix" "$rc" >/dev/null && echo true || echo false)
  # Check if the command is self-referencing
  # shellcheck disable=SC2155
  local self_ref=$(echo "$cmd" | awk -F "=" '{print $2}' | grep -q "\$$var" >/dev/null && echo true || echo false)
  run mkdir -p "$rc_dir"
  run touch "$rc"

  # No cmd match
  if ! $cmd_exists; then
    # If the prefix exists and the command is not self-referencing, update it
    if $prefix_exists && ! $self_ref; then
      # Select a delimiter not present in either $cmd or $prefix
      # shellcheck disable=SC2155
      local delim=$(seddelim "$prefix" "$cmd")
      local search="$prefix.*"
      local replace="$cmd"
      local sed="s$delim^$search$delim$replace$delim"
      echo "Updating '$cmd' in '$rc'"
      run sed -i.bak "$sed" "$rc" && run rm -rf "${rc}.bak"
    else
      # If the exact command doesn't exist and the prefix doesn't exist or the command is self-referencing, add the command
      echo "Adding '$cmd' into '$rc'"
      echo "$cmd" | run tee -a "$rc" >/dev/null
    fi
  fi
}

cmd="$1"
files="${2:-"$user_files"}"
sudo=$([[ $(id -u) -eq 0 ]] && echo true || echo false)
sudo_too=false
if [ "$files" = "user" ]; then
  files="$user_files"
elif [ "$files" = "sudo" ]; then
  sudo=true
  files="$sudo_files"
elif [ "$files" = "all" ]; then
  sudo_too=true
  files="$user_files"
fi

cmd_parts=()
toarray cmd_parts "$cmd" " "
if [ ${#cmd_parts[@]} -gt 0 ]; then
  if [[ "${cmd_parts[0]}" = 'sudo' ]] &>/dev/null; then
    sudo=true
    cmd="${cmd_parts[*]:1}"
    if [ "$files" = "$user_files" ]; then
      files="$sudo_files"
    fi
  fi
fi

rcs=()
toarray rcs "$files"
eval "$cmd" &>/dev/null || true
for rc in "${rcs[@]}"; do
  updaterc "$cmd" "$rc" "$sudo"
done

if $sudo_too; then
  sudo=true
  sudo_too=false
  files="$sudo_files"
  source "$0" "$cmd" sudo
fi
