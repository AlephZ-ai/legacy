# shellcheck shell=bash
set -euo pipefail
if [[ -z "${GITHUB_TOKEN}" ]] && ! gh auth status; then
  gh auth login
  gh config set -h github.com git_protocol https
  if uname -r | grep -q microsoft; then
    # Setup to use windows git credential manager if exists
    gcm="/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe"
    if [ -e "$(eval echo -e "$gcm")" ]; then
      echo "Updating credential helper to use windows"
      git config --global credential.helper "$gcm"
    fi
  else
    git-credential-manager configure
    git-credential-manager diagnose
  fi

  gh auth setup-git
  git lfs install --system
fi

gh auth status
