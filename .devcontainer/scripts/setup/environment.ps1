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
  $env:LEGACY_PROJECT_NAME = "devcontainer-features"
  $env:DEVCONTAINER_PROJECT_NAME = "devcontainer"
  Pop-Location
}

if ($PSVersionTable.PSEdition -eq 'Core') {
  $env:PSHELL="pwsh"
} else {
  $env:PSHELL="PowerShell"
}

Set-Alias -Name "pshell" -Value "$env:PSHELL"
$env:LEGACY_PROJECT_ROOT="$projectRoot"
$env:LEGACY_SOURCE_ROOT="$env:LEGACY_PROJECT_ROOT/src"
$env:DEVCONTAINER_PROJECT_ROOT="$env:LEGACY_PROJECT_ROOT/.devcontainer"
$env:DEVCONTAINER_SCRIPTS_ROOT="$env:DEVCONTAINER_PROJECT_ROOT/scripts"

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
