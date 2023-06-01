Write-Host "setup/windows/docker.ps1"
$env:GITHUB_TOKEN | docker login ghcr.io -u "$env:GITHUB_USERNAME" --password-stdin
