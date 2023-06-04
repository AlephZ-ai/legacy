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

  if [[ -n "$prefix" ]]; then
    # shellcheck disable=SC2016
    local awk_cmd='!index($0, p) {print $0} index($0, p) {print c}'

    if $sudo; then
      tmp="$(sudo mktemp)"
      sudo awk -v p="$prefix" -v c="$cmd" "$awk_cmd" "$rc" | sudo tee "$tmp" >/dev/null
      sudo mv "$tmp" "$rc"
    else
      tmp="$(mktemp)"
      awk -v p="$prefix" -v c="$cmd" "$awk_cmd" "$rc" >"$tmp"
      mv "$tmp" "$rc"
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

cmd="$1"
option="$2"

set -f
# shellcheck disable=SC2086
set -- $cmd
cmd_parts=("$@")

rcs=("$HOME/.bashrc" "$HOME/.zshrc")
if [[ "$option" == "sudo" ]]; then
  rcs=("/etc/bash.bashrc" "/etc/zsh/zshrc")
  if [[ $cmd != sudo* ]]; then cmd="sudo $cmd"; fi
else
  IFS=$';' read -ra rcs <<<"$(split_string "$option" ";")"
fi

sudo=false
[[ "${cmd_parts[0]}" = 'sudo' ]] && sudo=true

if $sudo; then
  cmd="${cmd_parts[*]:1}"
fi

eval "$cmd" &>/dev/null || true

for rc in "${rcs[@]}"; do
  updaterc "$cmd" "$rc" "$sudo"
done
