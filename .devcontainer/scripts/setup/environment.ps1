Push-Location "$projectRoot/.devcontainer"
try {
  Install-Module Set-PsEnv -ErrorAction Stop
  Import-Module Set-PsEnv -ErrorAction Stop
  Set-PsEnv -ErrorAction Stop
} catch {
  Write-Host "Set-PsEnv failed, attempting to manually read .env file"
  Get-Content .env | ForEach-Object {
    $key, $value = $_ -split '=', 2
    Set-Variable -Name $key -Value $value -Scope Global
  }
} finally {
  $env:DEVCONTAINER_FEATURES_PROJECT_NAME = "devcontainer-features"
  $env:DEVCONTAINER_PROJECT_NAME = "devcontainer"
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

try {
  $wd=wsl echo '$DISPLAY'
  if ($ERRORLEVEL -ne 0) { throw "WSL not found" }
  $env:LIB_WSL=/usr/lib/wsl
  if ($wd) {
    $env:MNT_WSLG=/mnt/wslg
    $env:X11_SOCKET=/tmp/.X11-unix
  } else {
    Write-Host "WSLg not found"
  }
} catch {
  Write-Host "WSL not found"
}
