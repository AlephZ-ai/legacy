Push-Location "$projectRoot/.devcontainer"
try {
    Install-Module Set-PsEnv
    Import-Module Set-PsEnv
    Set-PsEnv
    if ($LASTEXITCODE -ne 0) { Write-Host "Set-PsEnv failed"; throw "Exit code is $LASTEXITCODE" }
  } catch {
    $env:DEVCONTAINER_FEATURES_PROJECT_NAME="devcontainer-features"
    $env:DEVCONTAINER_PROJECT_NAME="devcontainer"
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
# Check if GITHUB_TOKEN or GITHUB_USERNAME is not set
if (!$env:GITHUB_TOKEN -or !$env:GITHUB_USERNAME) {
    # Check GitHub authentication status
    gh auth status > $null 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "You are not logged in to GitHub. Please login with 'gh auth login'."
        exit 1
    }

    # Check if GITHUB_TOKEN is not set
    if (!$env:GITHUB_TOKEN) {
        # Get the token using gh auth token
        $env:GITHUB_TOKEN = gh auth token
    }

    # Check if GITHUB_USERNAME is not set
    if (!$env:GITHUB_USERNAME) {
        # Get the username using gh api
        $env:GITHUB_USERNAME = gh api user --jq .login
    }
}
