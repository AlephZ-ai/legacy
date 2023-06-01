Write-Host "setup/windows/docker.ps1"
$env:GITHUB_TOKEN | docker login ghcr.io -u TOKEN --password-stdin
