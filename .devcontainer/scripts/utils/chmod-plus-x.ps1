#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
git update-index --add --chmod=+x "$env:LEGACY_PROJECT_ROOT/run"
git update-index --add --chmod=+x "$env:DEVCONTAINER_PROJECT_ROOT/init"
Get-ChildItem -Recurse -Path "$env:DEVCONTAINER_PROJECT_ROOT/scripts" -Filter "*.sh" | ForEach-Object { git update-index --add --chmod=+x $_.FullName }
Get-ChildItem -Recurse -Path "$env:LEGACY_PROJECT_ROOT/src" -Filter "*.sh" | ForEach-Object { git update-index --add --chmod=+x $_.FullName }
Get-ChildItem -Recurse -Path "$env:LEGACY_PROJECT_ROOT/test" -Filter "*.sh" | ForEach-Object { git update-index --add --chmod=+x $_.FullName }
Get-ChildItem -Recurse -Path "$env:LEGACY_PROJECT_ROOT" -Filter "*.ps1" | ForEach-Object { git update-index --add --chmod=+x $_.FullName }
