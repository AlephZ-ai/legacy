# shellcheck shell=bash
# init
set -euo pipefail
updaterc() {
  local cmd="$1"
  local rc="$2"
  local sudo="$3"
  local prefix="${cmd%%=*}="
  # shellcheck disable=SC2155
  local var="$(echo "$cmd" | awk -F "=" '{print $1}')"
  # shellcheck disable=SC2155
  local update=$(echo "$cmd" | awk -F "=" '{print $2}' | grep -q "\$$var" && echo false || echo true)
  # shellcheck disable=SC2155
  local rc_dir="$(dirname "$rc")"
  if $sudo; then
    sudo mkdir -p "$rc_dir"
    sudo touch "$rc"
  else
    mkdir -p "$rc_dir"
    touch "$rc"
  fi

  # Remove duplicates with awk, keep just the first occurrence
  # shellcheck disable=SC2016
  local seen='!seen[$0]++'
  if $sudo; then
    # shellcheck disable=SC2155
    local tmp_rc="$(sudo mktemp)"
    sudo awk "$seen" "$rc" | sudo tee "$tmp_rc" >/dev/null
    sudo mv "$tmp_rc" "$rc"
  else
    # shellcheck disable=SC2155
    local tmp_rc="$(mktemp)"
    awk "$seen" "$rc" >"$tmp_rc"
    mv "$tmp_rc" "$rc"
  fi

  # Select a delimiter not present in either $cmd or $prefix
  local delimiters=('/' '#' '@' '%' '_' '+' '-' ',')
  local delimiter
  for d in "${delimiters[@]}"; do
    if [[ "$cmd" != *$d* && "$prefix" != *$d* ]]; then
      delimiter=$d
      break
    fi
  done

  if [ -z "$delimiter" ]; then
    echo "No delimiter found for $cmd"
    exit 1
  fi

  # update var if it exists
  if $update && [[ -n "$prefix" ]]; then
    local search="$prefix.*"
    local replace="$cmd"
    local sed="s$delimiter^$search$delimiter$replace$delimiter"
    # echo "sed \"$sed_cmd\" \"$rc\""
    if $sudo; then
      sudo sed -i.bak "$sed" "$rc"
    else
      sed -i.bak "$sed" "$rc"
    fi
  fi

  # add cmd if it doesn't exist
  if $sudo; then
    if ! sudo grep -Fxq "$cmd" "$rc" >/dev/null; then
      echo -e "$cmd" | sudo tee -a "$rc" >/dev/null
    fi
  else
    if ! grep -Fxq "$cmd" "$rc"; then
      echo -e "$cmd" >>"$rc"
    fi
  fi
}

bash_ver=${BASH_VERSION:-}
zsh_ver=${ZSH_VERSION:-}
user_files="$HOME/.bashrc;$HOME/.zshrc"
sudo_files="/etc/bash.bashrc;/etc/zsh/zshrc"
sudo=$([[ $(id -u) -eq 0 ]] && echo true || echo false)
sudo_too=false
cmd="$1"
files="${2:-"$user_files"}"
if [ "$files" = "user" ]; then
  files="$user_files"
elif [ "$files" = "sudo" ]; then
  sudo=true
  files="$sudo_files"
elif [ "$files" = "all" ]; then
  sudo_too=true
  files="$user_files"
fi

set -f
# shellcheck disable=SC2086
set -- $cmd
# update sudo if needed
cmd_parts=()
sudo_index=1
if [ -n "$zsh_ver" ]; then
  eval 'cmd_parts=("${(@s/ /)cmd}")'
elif [ -n "$bash_ver" ]; then
  sudo_index=0
  cmd_parts=("$@")
else
  echo "Unknown shell: '$0'"
  exit 1
fi

if [[ "${cmd_parts[$sudo_index]}" = 'sudo' ]]; then
  sudo=true
  next_index=$((sudo_index + 1))
  cmd="${cmd_parts[*]:$next_index}"
fi

# update files if in sudo mode
if $sudo && [[ "$files" = "$user_files" ]]; then files="$sudo_files"; fi
rcs=()
if [ -n "$zsh_ver" ]; then
  eval 'rcs=("${(@s/;/)files}")'
elif [ -n "$bash_ver" ]; then
  IFS=';' read -ra rcs <<<"$files"
fi

# evaluate $cmd
eval "$cmd" &>/dev/null || true
for rc in "${rcs[@]}"; do
  echo "Updating $rc with $cmd"
  updaterc "$cmd" "$rc" "$sudo"
done

if $sudo_too; then
  sudo=true
  sudo_too=false
  files="$sudo_files"
  # shellcheck source=/dev/null
  source "$0" "$cmd" sudo
fi
