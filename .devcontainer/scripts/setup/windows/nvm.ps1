Write-Host "setup/windows/nvm.ps1"
nvm on | Write-Host
nvm version | Write-Host
# Install Node.js latest and lts
$nodes = 'latest', 'lts'
$packages = 'npm-check-updates', 'corepack', '@npmcli/fs', '@devcontainers/cli', 'dotenv-cli', 'typescript'

# You need to install nvm-windows before running these commands
# Download and install nvm-windows from https://github.com/coreybutler/nvm-windows/releases

# Make sure to restart your PowerShell console after installing nvm-windows
# Run this command to ensure nvm is installed: nvm version

foreach ($node in $nodes) {
    nvm install $node | Write-Host
    nvm use $node | Write-Host
    node --version | Write-Host
    npm install -g npm | Write-Host
    foreach ($package in $packages) {
        npm install -g $package | Write-Host
    }

    ncu -u | Write-Host
}

nvm use latest | Write-Host
