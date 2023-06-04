# shellcheck shell=bash
# Splits a string by semicolon
split_string() {
  IFS=';' read -r -a arr <<<"$1"
  echo -e "${arr[@]}"
}

cmd="$1"
if [[ -z "$2" ]]; then
  rcs=("$HOME/.bashrc" "$HOME/.zshrc")
else
  IFS=';' read -r -a rcs <<<"$(split_string "$2")"
fi

eval "$cmd"
echo "Updating ~/.bashrc and ~/.zshrc..."
for rc in "${rcs[@]}"; do
  if [[ "$(cat "$rc")" != *"$cmd"* ]]; then
    echo -e "$cmd" >>"$rc"
  fi
done
