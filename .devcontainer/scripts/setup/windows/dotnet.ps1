Write-Host "setup/windows/dotnet.ps1"
# dotnet workloads
dotnet workload install wasi-experimental | Write-Host
dotnet workload clean | Write-Host
dotnet workload update | Write-Host
dotnet workload repair | Write-Host

# dotnet tools
$modules = @('powershell', 'git-credential-manager', 'mlnet')
foreach ($module in $modules) {
  try {
    dotnet tool install -g "$module" | Write-Host
    if ($LASTEXITCODE -ne 0) { Write-Host "dotnet tool install -g $module failed"; throw "Exit code is $LASTEXITCODE" }
  } catch {
    Write-Host "Upgrading dotnet tool $module"
    dotnet tool update -g "$module" | Write-Host
  }
}
