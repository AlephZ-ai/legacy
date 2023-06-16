# shellcheck shell=bash
# shellcheck source=/dev/null
set -euo pipefail
repo_name="$1"
repo_owner="$2"
repo_dir="${3:-"$HOME/source/repos/$repo_name"}"
repo_cmd="${4:-}"
# shellcheck disable=SC2155
repo_ver="${5:-$(curl --silent "https://api.github.com/repos/$repo_owner/$repo_name/tags" | jq -r '.[0].name')}"
repo_url="https://github.com/$repo_owner/$repo_name.git"
echo "eval \"$repo_name=$repo_dir\""
eval "$repo_name=$repo_dir"

# If the repository doesn't exist, clone it
if [ ! -d "$repo_dir" ]; then
  git clone --branch "$repo_ver" --recurse-submodules "$repo_url" "$repo_dir"
fi

# Navigate to the repository
pushd "$repo_dir"

# Disable the detached head warning
git config advice.detachedHead false

# Fetch the latest tags and branches from the remote repository
git fetch --all

# If the current version is not the latest version, update the repo
if [[ "$(git rev-parse HEAD)" != "$(git rev-parse "$repo_ver")" ]]; then
  # Discard any uncommitted changes and remove untracked files
  git reset --hard
  git clean -fd

  # Checkout to the specific tag
  git checkout "$repo_ver"
  # Discard any uncommitted changes and remove untracked files in submodules
  git submodule foreach --recursive git reset --hard
  git submodule foreach --recursive git clean -fd

  # Update the submodules to the state at the checked out tag
  git submodule update --init --recursive
fi

# Run the provided command
if [ -n "$repo_cmd" ]; then
  echo "eval $repo_cmd"
  eval "$repo_cmd"
fi

popd
