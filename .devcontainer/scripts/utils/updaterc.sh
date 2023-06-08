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

  if [[ -n "$cmd" ]]; then
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
  fi

  # Select a delimiter not present in either $cmd or $prefix
  local delimiters=('#' ':' '@' '%' '_' '|' '&' '/')
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
    local sed="$delimiter^$prefix${delimiter}$cmd$delimiter"
    if $sudo; then
      sudo sed -i '' "$sed" "$rc" &>/dev/null
    else
      sed -i '' "$sed" "$rc" &>/dev/null
    fi
  fi

  # add cmd if it doesn't exist
  if $sudo; then
    if ! sudo grep -Fxq "$cmd" "$rc" >/dev/null; then
      echo -e "$cmd" | sudo tee -a "$rc" >/dev/null
    fi
  else
    if ! grep -Fxq "$cmd" "$rc" >/dev/null; then
      echo -e "$cmd" >>"$rc"
    fi
  fi
}

user_files="$HOME/.bashrc;$HOME/.zshrc"
sudo_files="/etc/bash.bashrc;/etc/zsh/zshrc"
sudo=$([[ $(id -u) -eq 0 ]] && echo true || echo false)
sudo_too=false
cmd="$1"
files="$2"
if [ -z "$files" ] || [ "$files" = "user" ]; then
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
cmd_parts=("$@")

# update sudo if needed
if [[ "${cmd_parts[0]}" = 'sudo' ]]; then
  sudo=true
  cmd="${cmd_parts[*]:1}"
fi

# update files if in sudo mode
if $sudo && [[ "$files" = "$user_files" ]]; then files="$sudo_files"; fi
rcs=()
if [ -n "$BASH_VERSION" ]; then
  IFS=';' read -ra rcs <<<"$files"
elif [ -n "$ZSH_VERSION" ]; then
  eval 'rcs=("${(@s/;/)files}")'
else
  echo "Unknown shell: '$0'"
  exit 1
fi

# evaluate $cmd
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
