# Configure GH
# Adding GH .ssh known hosts
New-Item -Path "$HOME\.ssh\" -ItemType Directory -Force | Out-Null
New-Item -Path "$HOME\.ssh\known_hosts" -ItemType File -Force | Out-Null
Invoke-Expression -Command "ssh-keyscan github.com >> `$HOME\.ssh\known_hosts"

# Configure GH
gh config set -h github.com git_protocol https | Write-Host
if (gh auth status | Write-Host) {
    gh auth setup-git | Write-Host
}
