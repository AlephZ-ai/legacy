& "$env:LEGACY_PROJECT_ROOT/run.ps1" -scriptPath devspace -script clean
docker system prune -a -f --volumes
