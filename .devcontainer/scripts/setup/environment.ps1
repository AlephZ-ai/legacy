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
  $env:DISPLAY=wsl echo '$DISPLAY'
  if ($LASTEXITCODE -ne 0) { throw "WSL not found" }
  $env:MNT_C="/mnt/c"
  $env:LIB_WSL="/usr/lib/wsl"
  $DEFAULT_XDG="/run/user/0/"
  $env:XDG_RUNTIME_DIR=wsl echo '$XDG_RUNTIME_DIR'
  if ($env:XDG_RUNTIME_DIR -eq "$DEFAULT_XDG") {
    try {
      # TODO: Work out something with default WSL distro instead of hardcoding Ubuntu, myabe setup/wsl/ubuntu could set the default distro?
      $env:XDG_RUNTIME_DIR=wsl --distribution Ubuntu echo '$XDG_RUNTIME_DIR'
    } catch {
      Write-Host "Ubuntu WSLg distribution not found"
      # TODO: Does trailing / cause an issue?
      # /run/user/1000/:/run/user/1000
      $env:XDG_RUNTIME_DIR="$DEFAULT_XDG"
    }
  }

  if ($env:DISPLAY) {
    $env:MNT_WSLG="/mnt/wslg"
    $env:X11_SOCKET="/tmp/.X11-unix"
    $env:WAYLAND_DISPLAY=wsl echo '$WAYLAND_DISPLAY'
    $env:PULSE_SERVER=wsl echo '$PULSE_SERVER'
  } else {
    Write-Host "WSLg not found"
  }
} catch {
  Write-Host "WSL not found"
}
