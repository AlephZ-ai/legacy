#!/usr/bin/env pwsh
dos2unix "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run"
dos2unix "$env:DEVCONTAINER_PROJECT_ROOT/init"
Get-ChildItem -Recurse -Path "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT" -Filter "*.sh" | ForEach-Object { dos2unix $_.FullName }
Get-ChildItem -Recurse -Path "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT" -Filter "*.ps1" | ForEach-Object { dos2unix $_.FullName }
