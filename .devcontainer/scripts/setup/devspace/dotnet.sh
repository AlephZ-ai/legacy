#!/usr/bin/env bash
# init
  set -ex
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
  updaterc() { local line="$1"; eval "$line"; echo "Updating ~/.bashrc and ~/.zshrc..."; rcs=("$HOME/.bashrc" "$HOME/.zshrc"); for rc in "${rcs[@]}"; do if [[ "$(cat "$rc")" != *"$line"* ]]; then echo "$line" >> "$rc"; fi; done }
# Setup dotnet
  preview="$(asdf list all dotnet-core 8)"
  dotnet_latest_major_global='{ "sdk": { "rollForward": "latestmajor" } }'
  updaterc 'export DOTNET_ROLL_FORWARD=LatestMajor'
  echo "$dotnet_latest_major_global" > "$HOME/global.json"
  # Update rc files
    root="\"\$HOME/.asdf/installs/dotnet-core/$preview\""
    cmd="export DOTNET_ROOT=$root"
    sed="s:^export DOTNET_ROOT=.*$:$cmd:"
    files=("$HOME/.bashrc" "$HOME/.zshrc")
    eval "$cmd"
    for file in "${files[@]}"; do
      sed -i "$sed" "$file"
      grep -qF "$cmd" "$file" || echo "$cmd" >> "$file"
    done
    # shellcheck source=/dev/null
    source "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.bash"
      # shellcheck disable=SC2016
      rcLine='source "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.bash"'
      rcFile="$HOME/.bashrc"
      grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
      # shellcheck disable=SC2016
      rcLine='source "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.zsh"'
      rcFile="$HOME/.zshrc"
      grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
  # Setup dotnet workloads
    dotnet workload install --include-previews wasi-experimental
    # Clean, repair, and update
      dotnet workload clean
      dotnet workload update
      dotnet workload repair
  # Setup dotnet tools
    tools=('powershell' 'git-credential-manager')
    for tool in "${tools[@]}"; do if [ -z "$(dotnet tool list -g | grep -q "$tool")" ]; then dotnet tool update -g "$tool"; else dotnet tool install -g "$tool"; fi; done
      # shellcheck disable=SC2016
    updaterc 'PATH="$HOME/.dotnet/tools:$PATH"'
    echo "$dotnet_latest_major_global" > "$HOME/.dotnet/tools/global.json"
