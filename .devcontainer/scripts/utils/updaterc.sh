# shellcheck shell=bash
set -ex

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

updaterc() {
  local cmd="$1"
  local rc="$2"
  local sudo="$3"

  echo "Updating $rc"
  local prefix="${cmd%%=*}="
  # shellcheck disable=SC2016
  local template='!index($0, p) {print $0} index($0, p) {print c}'
  if $sudo; then
    sudo touch "$rc"
  else
    touch "$rc"
  fi

  if [[ -n "$prefix" ]]; then
    if $sudo; then
      sudo awk -v p="$prefix" -v c="$cmd" "$template" "$rc" | sudo tee "/tmp/rc_tmp" >/dev/null
      sudo mv "/tmp/rc_tmp" "$rc"
    else
      awk -v p="$prefix" -v c="$cmd" "$template" "$rc" >"/tmp/rc_tmp"
      mv "/tmp/rc_tmp" "$rc"
    fi
  fi

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

defaultFiles="$HOME/.bashrc;$HOME/.zshrc"
cmd="$1"
files="${2:-"$defaultFiles"}"
set -f
# shellcheck disable=SC2086
set -- $cmd
cmd_parts=("$@")
sudo=false
if [[ "${cmd_parts[0]}" = 'sudo' ]]; then
  sudo=true
  cmd="${cmd_parts[*]:1}"
fi

rcs=()
if $sudo && [[ "$files" = "$defaultFiles" ]]; then
  rcs=("/etc/bash.bashrc" "/etc/zsh/zshrc")
else
  IFS=$';' read -ra rcs <<<"$(split_string "$files" ";")"
fi

eval "$cmd" &>/dev/null || true
for rc in "${rcs[@]}"; do
  updaterc "$cmd" "$rc" "$sudo"
done
