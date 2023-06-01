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
# Check if GITHUB_TOKEN is not set
if (!$env:GITHUB_TOKEN) {
  # Check if GitHub CLI is authenticated
  gh auth status > $null 2>&1
  if ($LASTEXITCODE -ne 0) {
    Write-Host "You are not logged in to GitHub. Please login with 'gh auth login'."
    exit 1
  } else {
    # Get GitHub token
    $env:GITHUB_TOKEN = gh auth token
  }
}
