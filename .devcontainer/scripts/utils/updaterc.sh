#!/usr/bin/env bash
set -e

updaterc() {
  local cmd="$1"
  local rc="$2"
  local sudo="$3"

  local prefix="${cmd%%=*}="
  # shellcheck disable=SC2016
  local template='!index($0, p) {print $0} index($0, p) {print c}'
  if $sudo; then
    sudo touch "$rc"
  else
    touch "$rc"
  fi

  if [[ -n "$cmd" ]]; then
    # Remove duplicates with awk
    # shellcheck disable=SC2016
    seen='!seen[$0]++'
    if $sudo; then
      sudo awk "$seen" "$rc" | sudo tee "/tmp/rc_tmp" >/dev/null
      sudo mv "/tmp/rc_tmp" "$rc"
    else
      awk "$seen" "$rc" >"/tmp/rc_tmp"
      mv "/tmp/rc_tmp" "$rc"
    fi
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
if $sudo || [[ $(id -u) -eq 0 ]] && [[ "$files" = "$defaultFiles" ]]; then
  rcs=("/etc/bash.bashrc" "/etc/zsh/zshrc")
else
  # bash-specific code here
  IFS=';' read -ra rcs <<<"$files"
fi

eval "$cmd" &>/dev/null || true
# shellcheck disable=SC2068
for rc in ${rcs[@]}; do
  updaterc "$cmd" "$rc" "$sudo"
done
