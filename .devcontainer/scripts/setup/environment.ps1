$projectRoot="$PSCommandPath" | Split-Path -Parent | Split-Path -Parent | Split-Path -Parent | Split-Path -Parent
Push-Location "$projectRoot/.devcontainer"
try {
    Set-PsEnv
} finally {
    Pop-Location
}

if ($PSVersionTable.PSEdition -eq 'Core') {
    $env:PSHELL="pwsh"
} else {
    $env:PSHELL="PowerShell"
}

Set-Alias -Name "pshell" -Value "$env:PSHELL"
$env:DEVCONTAINER_FEATURES_PROJECT_ROOT="$projectRoot"
$env:DEVCONTAINER_FEATURES_SOURCE_ROOT="$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/src"
$env:DEVCONTAINER_SCRIPTS_ROOT="$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer/scripts"
$env:DEVCONTAINER_POST_BUILD_COMMAND = Get-Content "$env:DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/post-build" -Raw