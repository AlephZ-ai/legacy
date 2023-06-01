if (-not ($env:GITHUB_TOKEN)) {
  try {
    gh auth status
    if ($LASTEXITCODE -ne 0) { Write-Host "gh auth status failed"; throw "Exit code is $LASTEXITCODE" }
  } catch {
    gh auth login
    gh config set -h github.com git_protocol https
  }
}

gh auth status