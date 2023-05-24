#!/usr/bin/env bash
#shellcheck shell=bash
#shellcheck source=/dev/null
#shellcheck disable=SC1090
#shellcheck disable=SC2016
set -e
# Refresh environment profile
reset
# Fix for dotnet
export PATH="/usr/local/dotnet/current:/usr/share/dotnet:$PATH"
rcLine='export PATH="/usr/local/dotnet/current:/usr/share/dotnet:$PATH"'
rcFile=~/.bashrc
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" | tee --append "$rcFile"
rcFile=~/.zshrc
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" | tee --append "$rcFile"
# Fix for dotnet tools
export PATH="$HOME/.dotnet/tools:$PATH"
rcLine='export PATH="$HOME/.dotnet/tools:$PATH"'
rcFile=~/.bashrc
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" | tee --append "$rcFile"
rcFile=~/.zshrc
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" | tee --append "$rcFile"
# Fix for git-credential-manager
export GCM_CREDENTIAL_STORE=cache
rcLine="export GCM_CREDENTIAL_STORE=cache"
rcFile=~/.bashrc
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" | tee --append "$rcFile"
rcFile=~/.zshrc
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" | tee --append "$rcFile"
sudo rm -rf /usr/share/dotnet || false
sudo ln -s /usr/local/dotnet/6.0.408 /usr/share/dotnet
# Fix for nvm
export NVM_SYMLINK_CURRENT="true"
export NVM_DIR="/usr/local/share/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
# Install Docker Completions
sudo rm -rf /etc/bash_completion.d/docker.sh || true
sudo mkdir -p /etc/bash_completion.d
sudo touch /etc/bash_completion.d/docker.sh
sudo curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh
sudo rm -rf /usr/share/zsh/vendor-completions/_docker || true
sudo mkdir -p /usr/share/zsh/vendor-completions
sudo touch /usr/share/zsh/vendor-completions/_docker
sudo curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/zsh/docker -o /usr/share/zsh/vendor-completions/_docker
# Check all tools are installed
docker --version
docker-compose --version
bash --version
zsh --version
pwsh --version
git --version
git-lfs --version
# TODO: Fix on devspace
# git-credential-manager --version
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
age --version
age-keygen --version
mkcert --version
chezmoi --version
psql --version
devcontainer --version
# Setup git credential manager
# TODO: Fix on devspace
# git-credential-manager configure
# git-credential-manager diagnose
# Make container a Root CA and trust it
mkcert -install
dotnet dev-certs https --trust
# Adding GH .ssh known hosts
mkdir -p ~/.ssh/
touch ~/.ssh/known_hosts
bash -c eval "$(ssh-keyscan github.com >> ~/.ssh/known_hosts)"
# Install Edge
sudo curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/microsoft.gpg
sudo install -o root -g root -m 644 /tmp/microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft.list'
sudo rm /tmp/microsoft.gpg
sudo apt update
sudo apt install -y microsoft-edge-beta microsoft-edge-dev
# TODO: Fix W: Target Packages (main/binary-amd64/Packages) is configured multiple times in /etc/apt/sources.list.d/microsoft-edge-beta.list:3 and /etc/apt/sources.list.d/microsoft-edge-dev.list:3
# Install Chrome
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb || true
sudo apt update
sudo apt install --fix-broken -y
sudo rm -rf /tmp/google-chrome-stable_current_amd64.deb
# Update
sudo apt install --fix-broken --fix-missing -y
sudo apt upgrade -y
# Select default browser
sudo update-alternatives --config x-www-browser
export BROWSER=/usr/bin/microsoft-edge-beta
rcLine="export BROWSER=/usr/bin/microsoft-edge-beta"
rcFile=~/.bashrc
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" | tee --append "$rcFile"
rcFile=~/.zshrc
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" | tee --append "$rcFile"
# Cleanup
sudo apt autoclean -y
sudo apt autoremove -y