#!/usr/bin/env zsh
#shellcheck shell=bash
# init
set -ex
updaterc() {
  line="$1"
  eval "$line"
  echo "Updating ~/.bashrc and ~/.zshrc..."
  rcs=("$HOME/.bashrc" "$HOME/.zshrc")
  for rc in "${rcs[@]}"; do if [[ "$(cat "$rc")" != *"$line"* ]]; then echo "$line" >>"$rc"; fi; done
}
# shellcheck source=/dev/null
source "$HOME/.zshrc"
# Test all tools are installed
docker --version
docker-compose --version
bash --version
zsh --version
pwsh --version
git --version
git-lfs --version
git-credential-manager --version
gitsign --version
gitsign-credential-cache --version
gh --version
dotnet --version
nvm --version
nvm version
npm --version
npm version
node --version
brew --version
asdf --version
age --version
age-keygen --version
mkcert --version
chezmoi --version
psql --version
devcontainer --version
# Done
echo "Devspace setup complete!"
