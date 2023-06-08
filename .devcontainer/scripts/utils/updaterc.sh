# shellcheck shell=bash
# init
set -euo pipefail
zsh_ver=${ZSH_VERSION:-}
user_files="$HOME/.bashrc;$HOME/.zshrc"
sudo_files="/etc/bash.bashrc;/etc/zsh/zshrc"
delimiters=('/' '#' '@' '%' '_' '+' '-' ',')
toarray() {
  local resultvar="$1"
  local input="$2"
  local delim="${3:-;}"
  local result=()
  set -f
  IFS="$delim"
  # shellcheck disable=SC2086
  set -- $input
  IFS=' '
  # shellcheck disable=SC2034
  result=("$@")
  eval "$resultvar=(\"\${result[@]}\")"
}

seddelim() {
  prefix="$1"
  cmd="$2"
  # Select a delimiter not present in either $cmd or $prefix
  local delim
  for d in "${delims[@]}"; do
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
  # shellcheck disable=SC2155
  local var="$(echo "$prefix" | awk '{print $NF}')"
  # shellcheck disable=SC2155
  local update=$(if [ -z "$var" ]; then echo false; else echo true; fi)
  # shellcheck disable=SC2155
  local rc_dir="$(dirname "$rc")"
  run() { if "$sudo"; then sudo "$@"; else "$@"; fi; }
  run mkdir -p "$rc_dir"
  run touch "$rc"
  # Remove duplicates with awk, keep just the first occurrence
  # shellcheck disable=SC2016
  local seen='!seen[$0]++'
  # shellcheck disable=SC2155
  local tmp_rc="$(run mktemp)"
  run awk "$seen" "$rc" | run tee "$tmp_rc" >/dev/null
  run mv "$tmp_rc" "$rc"
  # Select a delimiter not present in either $cmd or $prefix
  # shellcheck disable=SC2155
  local delim=$(seddelim "$prefix" "$cmd")
  if run grep -Fxq "$cmd" "$rc" >/dev/null; then
    if $update && [[ -n "$prefix" ]]; then
      local search="$prefix.*"
      local replace="$cmd"
      local sed="s$delim^$search$delim$replace$delim"
      echo "Updating '$rc' to include '$cmd'"
      run sed -i.bak "$sed" "$rc"
    fi
  else
    echo "Adding '$cmd' into '$rc'"
    echo -e "$cmd" | run tee -a "$rc" >/dev/null
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
sudo_index=0
if [ -n "$zsh_ver" ]; then sudo_index=1; fi
if [[ "${cmd_parts[$sudo_index]}" = 'sudo' ]]; then
  sudo=true
  next_index=$((sudo_index + 1))
  cmd="${cmd_parts[*]:$next_index}"
  files="$sudo_files"
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
  # shellcheck source=/dev/null
  source "$0" "$cmd" sudo
fi
