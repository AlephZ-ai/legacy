param (
  [Parameter(Mandatory=$true)]
  [string]$commandPath,
  [Parameter(Mandatory=$true)]
  [string]$command
)

& "$env:LEGACY_PROJECT_ROOT/run.ps1" -scriptPath devspace -script up
$containerid = docker ps -q -f name="$env:DEVCONTAINER_PROJECT_NAME-devspace"
devcontainer exec --container-id "$containerid" zsh -l -c "sudo `$LEGACY_PROJECT_ROOT/run` $commandPath $command"
