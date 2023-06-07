#!/usr/bin/env bash
# shellcheck shell=bash
# init
set -e
# shellcheck source=/dev/null
source "$HOME/.bashrc"
HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-/home/linuxbrew/.linuxbrew}
os=$(uname -s)
# Add autogenerate line
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" '# ------- pre-generated above this line -------'
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" '# ------- manual entry goes here -------'
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" '# ------- auto-generated below this line -------'
# Setup Homebrew
sudo echo "sudo cached"
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
# shellcheck source=/dev/null
source "$HOME/.bashrc"
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "eval \"\$(\"$HOMEBREW_PREFIX/bin/brew\" shellenv)\""
# Install taps
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
# Repair and Update if needed
brew update
brew tap --repair
# Install Homebrew packages
# linux only brews
if [ "$os" = "Linux" ]; then HOMEBREW_ACCEPT_EULA=Y brew install --include-test --debug-symbols --force procps systemd wayland wayland-protocols; fi
# These work on all brew platforms
while ! (
  HOMEBREW_ACCEPT_EULA=Y brew install --include-test --debug-symbols --force sevenzip p7zip awk ca-certificates bash zsh oh-my-posh file-formula gnu-sed coreutils grep curl wget bzip2 swig less lesspipe
  HOMEBREW_ACCEPT_EULA=Y brew install --include-test --debug-symbols --force zlib zlib-ng buf protobuf grpc dos2unix git git-lfs sigstore/tap/gitsign-credential-cache sigstore/tap/gitsign gh asdf
  HOMEBREW_ACCEPT_EULA=Y brew install --include-test --debug-symbols --force jq moreutils bash-completion@2 gcc make cmake cmake-docs z3 llvm dotnet dotnet@6 mono go rust python@3.11 nss openssl@3 openssl@1.1
  HOMEBREW_ACCEPT_EULA=Y brew install --include-test --debug-symbols --force openssh age nghttp2 mkcert shellcheck speedtest-cli mono-libgdiplus chezmoi sqlite sqlite-utils postgresql@15 azure-cli awscli
  HOMEBREW_ACCEPT_EULA=Y brew install --include-test --debug-symbols --force msodbcsql18 mssql-tools18 gedit kubernetes-cli helm minikube kind k3d argocd derailed/k9s/k9s kustomize skaffold vcluster
  HOMEBREW_ACCEPT_EULA=Y brew install --include-test --debug-symbols --force terraform openjdk openjdk@8 openjdk@11 openjdk@17 maven groovy gradle scala sbt yarn pygobject3 gtk+3 gtk+4 libffi libyaml
  HOMEBREW_ACCEPT_EULA=Y brew install --include-test --debug-symbols --force ffmpeg libsndfile libsoundio openmpi pyenv pipx
); do echo "Retrying"; done

# Upgrade all packages
brew update
brew upgrade
# Setup post hombrew packages
if [ "$os" = "Linux" ]; then
  sudo chsh "$USERNAME" -s "$(which zsh)"
  brew link --force --overwrite openssl@3
fi

brew link --force --overwrite postgresql@15
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "[[ -r \"$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh\" ]] && source \"$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh\"" "$HOME/.bashrc"
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "source \"$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export MONO_GAC_PREFIX=\"$HOMEBREW_PREFIX\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export DOTNET_ROOT=\"$HOMEBREW_PREFIX/opt/dotnet/libexec\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export GROOVY_HOME=\"$HOMEBREW_PREFIX/opt/groovy/libexec\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export SCALA_HOME=\"$HOMEBREW_PREFIX/opt/scala/idea\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export PATH=\"$HOMEBREW_PREFIX/opt/python/libexec/bin:\$PATH\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export PATH=\"$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:\$PATH\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export PATH=\"$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:\$PATH\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export PATH=\"$HOMEBREW_PREFIX/opt/grep/libexec/gnubin:\$PATH\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export PATH=\"$HOMEBREW_PREFIX/opt/make/libexec/gnubin:\$PATH\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export MANPATH=\"$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:\$MANPATH\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export MANPATH=\"$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnuman:\$MANPATH\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export MANPATH=\"$HOMEBREW_PREFIX/opt/grep/libexec/gnuman:\$MANPATH\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export MANPATH=\"$HOMEBREW_PREFIX/opt/make/libexec/gnuman:\$MANPATH\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export LESSOPEN=\"|$HOMEBREW_PREFIX/bin/lesspipe.sh %s\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export LDFLAGS=\"-L$HOMEBREW_PREFIX/opt/curl/lib\${LDFLAGS:+ }\$LDFLAGS\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export CPPFLAGS=\"-I$HOMEBREW_PREFIX/opt/curl/include\${CPPFLAGS:+ }\$CPPFLAGS\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export LDFLAGS=\"-L$HOMEBREW_PREFIX/opt/bzip2/lib\${LDFLAGS:+ }\$LDFLAGS\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export CPPFLAGS=\"-I$HOMEBREW_PREFIX/opt/bzip2/include\${CPPFLAGS:+ }\$CPPFLAGS\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export LDFLAGS=\"-L$HOMEBREW_PREFIX/opt/zlib/lib\${LDFLAGS:+ }\$LDFLAGS\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export CPPFLAGS=\"-I$HOMEBREW_PREFIX/opt/zlib/include\${CPPFLAGS:+ }\$CPPFLAGS\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export LDFLAGS=\"-L$HOMEBREW_PREFIX/opt/llvm/lib/c++ -Wl,-rpath,$HOMEBREW_PREFIX/opt/llvm/lib/c++\${LDFLAGS:+ }\$LDFLAGS\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export LDFLAGS=\"-L$HOMEBREW_PREFIX/opt/llvm/lib\${LDFLAGS:+ }\$LDFLAGS\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export CPPFLAGS=\"-I$HOMEBREW_PREFIX/opt/llvm/include\${CPPFLAGS:+ }\$CPPFLAGS\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export CPPFLAGS=\"-I$HOMEBREW_PREFIX/opt/openjdk/include\${CPPFLAGS:+ }\$CPPFLAGS\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export LDFLAGS=\"-L$HOMEBREW_PREFIX/opt/libffi/lib\${LDFLAGS:+ }\$LDFLAGS\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export CPPFLAGS=\"-I$HOMEBREW_PREFIX/opt/libffi/include\${CPPFLAGS:+ }\$CPPFLAGS\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export LDFLAGS=\"-L$HOMEBREW_PREFIX/opt/postgresql@15/lib\${LDFLAGS:+ }\$LDFLAGS\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export CPPFLAGS=\"-I$HOMEBREW_PREFIX/opt/postgresql@15/include\${CPPFLAGS:+ }\$CPPFLAGS\""
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export PKG_CONFIG_PATH=\"$HOMEBREW_PREFIX/opt/postgresql@15/lib/pkgconfig\${PKG_CONFIG_PATH:+:}\$PKG_CONFIG_PATH\""

# Run Homebrew cleanup and doctor to check for errors
brew cleanup
brew doctor || true
