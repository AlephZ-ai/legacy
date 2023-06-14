#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
set -euo pipefail
if [ -e "$HOME/.cargo/env" ]; then source "$HOME/.cargo/env"; fi
if command -v rustup >/dev/null 2>&1; then
  export RUST_FAST_LEVEL=${RUST_FAST_LEVEL:-${FAST_LEVEL:-0}}
else
  export RUST_FAST_LEVEL=0
fi

echo "RUST_FAST_LEVEL=$RUST_FAST_LEVEL"
if [ "$RUST_FAST_LEVEL" -eq 0 ]; then
  RUSTUP_INIT_SKIP_PATH_CHECK=yes curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile complete --default-toolchain nightly
fi

# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'source "$HOME/.cargo/env"'
if [ "$RUST_FAST_LEVEL" -eq 0 ]; then
  rustup component add llvm-tools-preview
fi
