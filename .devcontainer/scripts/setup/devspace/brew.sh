#!/usr/bin/env bash
# init
  set -e
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
  updaterc() { local line="$1"; eval "$line"; echo "Updating ~/.bashrc and ~/.zshrc..."; rcs=("$HOME/.bashrc" "$HOME/.zshrc"); for rc in "${rcs[@]}"; do if [[ "$(cat "$rc")" != *"$line"* ]]; then echo "$line" >> "$rc"; fi; done }
  HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-/home/linuxbrew/.linuxbrew}
  os=$(uname -s)
# Setup Homebrew
  sudo echo "sudo cached"
  NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
  cat "$HOME/.bashrc"
  updaterc "eval \"\$(\"$HOMEBREW_PREFIX/bin/brew\" shellenv)\""
  # Install taps
    brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
  # Repair and Update if needed
    brew update
    brew tap --repair
  # Install Homebrew packages
    # linux only brews
      if [ "$os" == "Linux" ]; then HOMEBREW_ACCEPT_EULA=Y brew install procps systemd wayland wayland-protocols; fi
    # These work on all brew platforms
      while ! (
        sudo echo "cache sudo"
        HOMEBREW_ACCEPT_EULA=Y brew install sevenzip p7zip awk ca-certificates bash zsh oh-my-posh file-formula gnu-sed coreutils grep curl wget bzip2 less lesspipe
        HOMEBREW_ACCEPT_EULA=Y brew install zlib zlib-ng buf protobuf grpc dos2unix git git-lfs sigstore/tap/gitsign-credential-cache sigstore/tap/gitsign gh asdf
        HOMEBREW_ACCEPT_EULA=Y brew install jq moreutils bash-completion@2 gcc make cmake cmake-docs llvm dotnet dotnet@6 mono go rust python@3.11 nss openssl@3 openssl@1.1
        HOMEBREW_ACCEPT_EULA=Y brew install openssh age nghttp2 mkcert shellcheck speedtest-cli mono-libgdiplus chezmoi sqlite sqlite-utils postgresql@15 azure-cli awscli
        HOMEBREW_ACCEPT_EULA=Y brew install msodbcsql18 mssql-tools18 gedit kubernetes-cli helm minikube kind k3d kubefirst argocd derailed/k9s/k9s kustomize skaffold vcluster
        HOMEBREW_ACCEPT_EULA=Y brew install terraform openjdk openjdk@8 openjdk@11 openjdk@17 maven groovy gradle scala sbt yarn
      ) do echo "Retrying"; done

  # Upgrade all packages
    brew update
    brew upgrade
  # Setup post hombrew packages
    if [ "$os" == "Linux" ]; then
      sudo chsh "$USERNAME" -s "$(which zsh)"
      brew link --force --overwrite openssl@3
    fi

    brew link --force --overwrite postgresql@15
    # shellcheck source=/dev/null
    [[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]] && source "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
    rcLine="[[ -r \"$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh\" ]] && source \"$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh\""
    grep -qxF "$rcLine" "$HOME/.bashrc" || echo "$rcLine" >> "$HOME/.bashrc"
    updaterc "source \"$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh\""
    updaterc "export MONO_GAC_PREFIX=\"$HOMEBREW_PREFIX\""
    updaterc "export DOTNET_ROOT=\"$HOMEBREW_PREFIX/opt/dotnet/libexec\""
    updaterc "export GROOVY_HOME=\"$HOMEBREW_PREFIX/opt/groovy/libexec\""
    updaterc "export SCALA_HOME=\"$HOMEBREW_PREFIX/opt/scala/idea\""
    updaterc "export PATH=\"$HOMEBREW_PREFIX/opt/python/libexec/bin:\$PATH\""
    updaterc "export PATH=\"$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:\$PATH\""
    updaterc "export PATH=\"$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:\$PATH\""
    updaterc "export PATH=\"$HOMEBREW_PREFIX/opt/grep/libexec/gnubin:\$PATH\""
    updaterc "export PATH=\"$HOMEBREW_PREFIX/opt/make/libexec/gnubin:\$PATH\""
    updaterc "export MANPATH=\"$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:\$MANPATH\""
    updaterc "export MANPATH=\"$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnuman:\$MANPATH\""
    updaterc "export MANPATH=\"$HOMEBREW_PREFIX/opt/grep/libexec/gnuman:\$MANPATH\""
    updaterc "export MANPATH=\"$HOMEBREW_PREFIX/opt/make/libexec/gnuman:\$MANPATH\""
    updaterc "export LESSOPEN=\"|$HOMEBREW_PREFIX/bin/lesspipe.sh %s\""
    updaterc "export LDFLAGS=\"-L$HOMEBREW_PREFIX/opt/curl/lib\${LDFLAGS:+ }\$LDFLAGS\""
    updaterc "export CPPFLAGS=\"-I$HOMEBREW_PREFIX/opt/curl/include\${CPPFLAGS:+ }\$CPPFLAGS\""
    updaterc "export LDFLAGS=\"-L$HOMEBREW_PREFIX/opt/bzip2/lib\${LDFLAGS:+ }\$LDFLAGS\""
    updaterc "export CPPFLAGS=\"-I$HOMEBREW_PREFIX/opt/bzip2/include\${CPPFLAGS:+ }\$CPPFLAGS\""
    updaterc "export LDFLAGS=\"-L$HOMEBREW_PREFIX/opt/zlib/lib\${LDFLAGS:+ }\$LDFLAGS\""
    updaterc "export CPPFLAGS=\"-I$HOMEBREW_PREFIX/opt/zlib/include\${CPPFLAGS:+ }\$CPPFLAGS\""
    updaterc "export LDFLAGS=\"-L$HOMEBREW_PREFIX/opt/llvm/lib/c++ -Wl,-rpath,$HOMEBREW_PREFIX/opt/llvm/lib/c++\${LDFLAGS:+ }\$LDFLAGS\""
    updaterc "export LDFLAGS=\"-L$HOMEBREW_PREFIX/opt/llvm/lib\${LDFLAGS:+ }\$LDFLAGS\""
    updaterc "export CPPFLAGS=\"-I$HOMEBREW_PREFIX/opt/llvm/include\${CPPFLAGS:+ }\$CPPFLAGS\""
    updaterc "export CPPFLAGS=\"-I$HOMEBREW_PREFIX/opt/openjdk/include\${CPPFLAGS:+ }\$CPPFLAGS\""
    updaterc "export LDFLAGS=\"-L$HOMEBREW_PREFIX/opt/postgresql@15/lib\${LDFLAGS:+ }\$LDFLAGS\""
    updaterc "export CPPFLAGS=\"-I$HOMEBREW_PREFIX/opt/postgresql@15/include\${CPPFLAGS:+ }\$CPPFLAGS\""
    updaterc "export PKG_CONFIG_PATH=\"$HOMEBREW_PREFIX/opt/postgresql@15/lib/pkgconfig\${PKG_CONFIG_PATH:+:}\$PKG_CONFIG_PATH\""

  # Run Homebrew cleanup and doctor to check for errors
    brew cleanup
    brew doctor || true
