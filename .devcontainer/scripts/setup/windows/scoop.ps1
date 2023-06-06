Write-Host "setup/windows/scoop.ps1"
# https://scoop.sh/
scoop install --global 7zip | Write-Host
scoop update --all --global | Write-Host
scoop update | Write-Host
$complete = $false
do {
    try {
        scoop install --global touch patch | Write-Host
        scoop install --global gawk cacert file sed coreutils grep curl wget bzip2 swig less | Write-Host
        scoop install --global zlib buf protobuf grpc-tools dos2unix gitsign gh | Write-Host
        scoop install --global jq gcc make cmake llvm dotnet-nightly dotnet-sdk-preview dotnet-sdk dotnet-sdk-lts mono go rust openssl openssh age | Write-Host
        scoop install --global mkcert shellcheck speedtest-cli chezmoi sqlite postgresql azure-cli aws | Write-Host
        scoop install --global gedit kubeadm kubectl helm minikube kind k3d argo-cd k9s kustomize skaffold vcluster | Write-Host
        scoop install --global terraform openjdk openjdk-ea openjdk openjdk11 openjdk17 openjdk21 openjdk8-redhat microsoft-jdk maven groovy gradle scala scala-cli sbt | Write-Host
        scoop install --global nvm vulkan fiddler speedtest gimp vlc azuredatastudio azuredatastudio-insiders | Write-Host
        scoop install --global ffmepg msmpi | Write-Host
        if ($LASTEXITCODE -ne 0) { Write-Host "scoop install --global failed"; throw "Exit code is $LASTEXITCODE" }
        $complete = $true
    } catch [Exception] {
        Write-Host $_.Exception.Message
        Write-Host "Retrying"
    }
} while (-not $complete)

scoop update --all --global | Write-Host
Stop-Service -Force sshd
C:\ProgramData\scoop\apps\openssh\current\install-sshd.ps1 | Write-Host
regedit /s C:\ProgramData\scoop\apps\zlib\current\register.reg | Write-Host
regedit /s "$HOME\scoop\apps\python\current\install-pep-514.reg" | Write-Host
# scoop update
scoop update | Write-Host
scoop update --all | Write-Host
scoop update --all --global | Write-Host
scoop status | Write-Host
