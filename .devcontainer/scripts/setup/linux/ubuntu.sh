#shellcheck shell=bash
#shellcheck source=/dev/null
#shellcheck disable=SC2016
set -e
# Get current user
CURRENT_USER="$(whoami)"
# Update submodules
pushd "$DEVCONTAINER_FEATURES_PROJECT_ROOT"
git submodule sync --recursive
git submodule update --init --recursive
git submodule foreach --recursive git checkout main
git submodule foreach --recursive git pull
popd
# Install apt-packages
sudo apt update
sudo apt install -y --fix-broken --fix-missing
sudo apt upgrade -y
packages="sudo,grep,bzip2,fonts-dejavu-core,g++,git,less,locales,openssl,make,netbase,openssh-client,patch,tzdata,uuid-runtime,apt-transport-https,ca-certificates,speedtest-cli,checkinstall,dos2unix,shellcheck,file,wget,curl,zsh,bash,procps,software-properties-common,libnss3,libnss3-tools,build-essential,zlib1g-dev,gcc,bash-completion,age,powerline,fonts-powerline,gedit,gimp,nautilus,vlc,x11-apps"
sudo PACKAGES="$packages" UPDATEPACKAGES="true" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id rocker-org/devcontainer-features apt-packages install
age --version
age-keygen --version
# Install common-utils
# This messes up permissions for wsl user
# sudo USERNAME="$CURRENT_USER" INSTALLZSH="true" CONFIGUREZSHASDEFAULTSHELL="true" INSTALLOHMYZSH="true" USERUID="$CURRENT_UID" USERGID="$CURRENT_GID" NONFREEPACKAGES="true" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id devcontainers/features common-utils install
zsh --version
sudo chsh "$CURRENT_USER" -s "$(which zsh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
# Install Brew
sudo USERNAME="$CURRENT_USER" BREWS="bash zsh grep git git-lfs sigstore/tap/gitsign gh mkcert chezmoi postgresql@15" LINKS="postgresql@15" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -s homebrew install
# Refresh environment profile
reset
brew --version
bash --version
zsh --version
mkcert --version
chezmoi --version
gitsign-credential-cache --version
psql --version
# Install dotnet
sudo rm -rf /usr/local/dotnet
sudo USERNAME="$CURRENT_USER" TOOLS="git-credential-manager" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -s dotnet install;
export PATH="/usr/local/dotnet/current:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"
export GCM_CREDENTIAL_STORE=cache
dotnet --version
# Install PowerShell
sudo VERSION="latest" MODULES="Set-PsEnv,Pester" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id devcontainers/features powershell install
pwsh --version
# Install nvm
export NVM_DIR="/usr/local/share/nvm"
export PATH="$PATH:/usr/local/share/nvm/current/bin"
export NVM_SYMLINK_CURRENT="true"
sudo USERNAME="$CURRENT_USER" NODEGYPDEPENDENCIES="true" PACKAGES="@npmcli/fs,@devcontainers/cli,dotenv-cli" NVM_DIR="$NVM_DIR" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -s nvm install
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
nvm --version
node --version
docker --version
docker-compose --version
# Continue with devspace setup
"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup devspace
# Log into GitHub
if ! gh auth status; then gh auth login; fi
gh config set -h github.com git_protocol https
gh auth status
# Setup git credential manager
git-credential-manager configure
git-credential-manager diagnose
echo "Don't forget to set your git credentials:"
echo 'git config --global user.name "Your Name"'
echo 'git config --global user.email "youremail@yourdomain.com"'
echo "WARNING: Please restart shell to get latest environment variables"