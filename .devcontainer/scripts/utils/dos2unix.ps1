dos2unix "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run"
dos2unix "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer/init"
Get-ChildItem -Recurse -Path "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer/scripts" -Filter "*.sh" | ForEach-Object { dos2unix $_.FullName }
Get-ChildItem -Recurse -Path "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/src" -Filter "*.sh" | ForEach-Object { dos2unix $_.FullName }
Get-ChildItem -Recurse -Path "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/test" -Filter "*.sh" | ForEach-Object { dos2unix $_.FullName }
