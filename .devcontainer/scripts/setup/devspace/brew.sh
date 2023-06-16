#!/bin/zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
# init
set -euo pipefail
os=$(uname -s)
if [ -z "${HOMEBREW_PREFIX:-}" ]; then
  if command -v brew >/dev/null 2>&1; then
    # shellcheck disable=SC2155
    export HOMEBREW_PREFIX="$(brew --prefix)"
  elif [ "$os" = "Linux" ]; then
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  else
    export HOMEBREW_PREFIX="/usr/local"
  fi
fi

# Check fast level
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export HOMEBREW_PREFIX=\"$HOMEBREW_PREFIX\""
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export PATH=\"$HOMEBREW_PREFIX/bin:\$PATH\""
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export PATH=\"$HOMEBREW_PREFIX/sbin:\$PATH\""
if command -v brew >/dev/null 2>&1; then
  export BREW_FAST_LEVEL=${BREW_FAST_LEVEL:-${FAST_LEVEL:-0}}
else
  export BREW_FAST_LEVEL=0
fi

echo "BREW_FAST_LEVEL=$BREW_FAST_LEVEL"
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export HOMEBREW_PREFIX=\"$HOMEBREW_PREFIX\""
# Setup Homebrew
sudo echo "sudo cached"
if [ "$BREW_FAST_LEVEL" -eq 0 ]; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'eval "$("$HOMEBREW_PREFIX/bin/brew" shellenv)"'
if [ "$BREW_FAST_LEVEL" -eq 0 ]; then
  # Install taps
  brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
  # Repair and Update if needed
  brew update
  brew tap --repair
  # Install Homebrew packages
  HOMEBREW_ACCEPT_EULA=Y brew install --include-test bash zsh
  # linux only brews
  if [ "$os" = "Linux" ]; then
    HOMEBREW_ACCEPT_EULA=Y brew install --include-test procps systemd wayland wayland-protocols
  fi

  HOMEBREW_ACCEPT_EULA=Y brew install --include-test ca-certificates coreutils moreutils readline xz make cmake cmake-docs ninja antigen oh-my-posh pyenv pyenv-virtualenv pipx virtualenv
  # TODO: Fix fontconfig
  HOMEBREW_ACCEPT_EULA=Y brew install --include-test fontconfig || true
  brew postinstall fontconfig || true
  # shellcheck disable=SC2016
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'source "$HOMEBREW_PREFIX/share/antigen/antigen.zsh"' "$HOME/.zshrc"
  # shellcheck disable=SC2034
  while ! (
    HOMEBREW_ACCEPT_EULA=Y brew install --include-test sevenzip p7zip awk file-formula gnu-sed grep curl wget bzip2 swig less lesspipe tcl-tk libuv jq yq nlohmann-json gflags libusb
    HOMEBREW_ACCEPT_EULA=Y brew install --include-test zlib zlib-ng flatbuffers snappy buf protobuf grpc dos2unix git git-lfs sigstore/tap/gitsign-credential-cache sigstore/tap/gitsign gh subversion
    HOMEBREW_ACCEPT_EULA=Y brew install --include-test gcc llvm clang-format clang-build-analyzer dotnet dotnet@6 mono go rust perl ruby python python-tk python@3.9 python-tk@3.9 python@3.10 python-tk@3.10 python@3.11 python-tk@3.11
    HOMEBREW_ACCEPT_EULA=Y brew install --include-test nss openssl openssl@1.1 openssl@3 openssh age nghttp2 mkcert shellcheck speedtest-cli mono-libgdiplus chezmoi sqlite sqlite-utils sqlite-analyzer postgresql@15
    HOMEBREW_ACCEPT_EULA=Y brew install --include-test openjdk openjdk@8 openjdk@11 openjdk@17 maven groovy gradle scala sbt yarn bash-completion@2 z3 asdf tbb scons fdupes pugixml molten-vk
    HOMEBREW_ACCEPT_EULA=Y brew install --include-test azure-cli awscli msodbcsql18 mssql-tools18 kubernetes-cli helm minikube kind k3d argocd derailed/k9s/k9s kustomize skaffold vcluster
    HOMEBREW_ACCEPT_EULA=Y brew install --include-test python-typing-extensions pygobject3 py3cairo pyyaml libffi libyaml qt pyqt boost boost-build boost-mpi boost-python3 terraform gtk+3 gtk+4
    HOMEBREW_ACCEPT_EULA=Y brew install --include-test ffmpeg libsndfile libsoundio libomp openmpi opencv openvino bats-core gedit git-gui git-svn numpy scipy libtensorflow pytorch torchvision neovim
  ); do echo "Retrying"; done

  # Setup post hombrew packages
  links=()
  if [ "$os" = "Linux" ]; then
    links+=('file-formula' 'curl' 'readline' 'bzip2' 'protobuf' 'zlib' 'libffi' 'llvm' 'tcl-tk' 'sqlite' 'openssl@3' 'openjdk')
  fi

  links+=('make' 'cmake' 'gnu-sed' 'grep' 'coreutils' 'xz' 'python-tk@3.11' 'python@3.11' 'postgresql@15' 'qt' 'pyqt' 'openvino')
  for brew in "${links[@]}"; do brew unlink "$brew"; done
  for brew in "${links[@]}"; do brew link --overwrite "$brew"; done
fi

# Setup post hombrew packages
if [ "$BREW_FAST_LEVEL" -le 2 ]; then
  # shellcheck disable=SC2016
  "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" '[[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]] && source "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"' "$HOME/.bashrc"
  # shellcheck disable=SC2016
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'export LESSOPEN="|$HOMEBREW_PREFIX/bin/lesspipe.sh %s"'
  # shellcheck disable=SC2016
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'export MONO_GAC_PREFIX="$HOMEBREW_PREFIX"'
  # shellcheck disable=SC2016
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'export GROOVY_HOME="$HOMEBREW_PREFIX/opt/groovy/libexec"'
  # shellcheck disable=SC2016
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'export SCALA_HOME="$HOMEBREW_PREFIX/opt/scala/idea"'
  # shellcheck disable=SC2016
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'export DOTNET_ROOT="$HOMEBREW_PREFIX/share/dotnet"'
  exports=('file-formula' 'curl' 'readline' 'bzip2' 'protobuf' 'zlib' 'libffi' 'llvm' 'tcl-tk' 'sqlite' 'openssl@3' 'openjdk' 'gmake' 'gnu-sed' 'grep' 'coreutils' 'xz' 'dotnet' 'python-tk@3.11' 'python@3.11' 'postgresql@15' 'qt' 'pyqt' 'llibomp' 'openvino')
  for brew in "${exports[@]}"; do
    # shellcheck disable=SC2016
    brew_dir="\$HOMEBREW_PREFIX/opt/$brew"
    brew_bin_dir="$brew_dir/bin"
    brew_sbin_dir="$brew_dir/sbin"
    brew_include_dir="$brew_dir/include"
    brew_lib_dir="$brew_dir/lib"
    brew_pkgconfig_dir="$brew_lib_dir/pkgconfig"
    # shellcheck disable=SC2016
    brew_libexec_dir="\$HOMEBREW_PREFIX/opt/$brew/libexec"
    brew_libexec_bin_dir="$brew_libexec_dir/bin"
    brew_libexec_sbin_dir="$brew_libexec_dir/sbin"
    brew_gnubin_dir="$brew_libexec_dir/gnubin"
    brew_gnuman_dir="$brew_libexec_dir/gnuman"
    if [ -e "$(eval echo "$brew_bin_dir")" ]; then source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export PATH=\"$brew_bin_dir:\$PATH\""; fi
    if [ -e "$(eval echo "$brew_sbin_dir")" ]; then source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export PATH=\"$brew_sbin_dir:\$PATH\""; fi
    if [ -e "$(eval echo "$brew_libexec_bin_dir")" ]; then source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export PATH=\"$brew_libexec_bin_dir:\$PATH\""; fi
    if [ -e "$(eval echo "$brew_libexec_sbin_dir")" ]; then source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export PATH=\"$brew_libexec_sbin_dir:\$PATH\""; fi
    if [ -e "$(eval echo "$brew_gnubin_dir")" ]; then source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export PATH=\"$brew_gnubin_dir:\$PATH\""; fi
    if [ -e "$(eval echo "$brew_gnuman_dir")" ]; then source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export MANPATH=\"$brew_gnuman_dir\${MANPATH:+:}\${MANPATH:-}\""; fi
    if [ -e "$(eval echo "$brew_include_dir")" ]; then source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export CPPFLAGS=\"-I$brew_include_dir\${CPPFLAGS:+ }\${CPPFLAGS:-}\""; fi
    if [ -e "$(eval echo "$brew_lib_dir")" ]; then source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export LDFLAGS=\"-L$brew_lib_dir\${LDFLAGS:+ }\${LDFLAGS:-}\""; fi
    if [ "$brew" = "llvm" ]; then source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export LDFLAGS=\"-L$brew_lib_dir/c++ -Wl,-rpath,$brew_lib_dir/c++\${LDFLAGS:+ }\${LDFLAGS:-}\""; fi
    if [ -e "$(eval echo "$brew_pkgconfig_dir")" ]; then source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export PKG_CONFIG_PATH=\"$brew_pkgconfig_dir\${PKG_CONFIG_PATH:+:}\${PKG_CONFIG_PATH:-}\""; fi
    # # shellcheck disable=SC2016
    # if [ "$brew" = "openvino" ]; then source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'export OpenVINO_ROOT_DIR=$(brew info --json openvino | jq -r '\''.[0].installed[0].prefix'\'')'; fi
  done
fi

if [ "$BREW_FAST_LEVEL" -eq 0 ]; then
  # Run Homebrew post install
  if [ -n "$BREW_POST_INSTALL" ]; then
    while ! eval "$BREW_POST_INSTALL"; do echo "Retrying"; done
  fi
fi

if [ "$BREW_FAST_LEVEL" -le 1 ]; then
  # Upgrade all packages
  brew update
  brew upgrade
  # Run Homebrew cleanup and doctor to check for errors
  brew cleanup
  brew doctor || true
fi
