# shellcheck shell=bash
# Splits a string by semicolon
split_string() {
  IFS=';' read -r -a arr <<<"$1"
  echo "${arr[@]}"
}

cmd="$1"
IFS=' ' read -r -a rcs <<<"$(split_string "${2:-"$HOME/.bashrc";"$HOME/.zshrc"}")"
eval "$cmd"
echo "Updating ~/.bashrc and ~/.zshrc..."
rcs=("$rc1" "$rc2")
for rc in "${rcs[@]}"; do
  if [[ "$(cat "$rc")" != *"$cmd"* ]]; then
    echo "$cmd" >>"$rc"
  fi
done
