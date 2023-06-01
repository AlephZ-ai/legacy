gh config set -h github.com git_protocol https
git-credential-manager configure
git-credential-manager diagnose
gh auth setup-git

try {
  gh auth status
  if ($LASTEXITCODE -ne 0) { Write-Host "gh auth status failed"; throw "Exit code is $LASTEXITCODE" }
} catch {
  if ($env:GITHUB_TOKEN) {
    "$GITHUB_TOKEN" | gh auth login --with-token
  }
}

try {
  gh auth status
  if ($LASTEXITCODE -ne 0) { Write-Host "gh auth status failed"; throw "Exit code is $LASTEXITCODE" }
} catch {
  gh auth login
}

gh auth status
