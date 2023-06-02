Write-Host "setup/windows/scoop.ps1"
# https://scoop.sh/
scoop install --global 7zip
scoop update --all --global
scoop update
$complete = $false
do {
    try {
        scoop install --global touch patch
        scoop install --global gawk cacert file sed coreutils grep curl wget bzip2 less
        scoop install --global zlib buf protobuf grpc-tools dos2unix gitsign gh
        scoop install --global jq gcc make cmake llvm dotnet-nightly dotnet-sdk-preview dotnet-sdk dotnet-sdk-lts mono go rust python openssl openssh age 
        scoop install --global mkcert shellcheck speedtest-cli chezmoi sqlite postgresql azure-cli aws
        scoop install --global gedit kubeadm kubectl helm minikube kind k3d argo-cd k9s kustomize skaffold vcluster
        scoop install --global terraform openjdk openjdk-ea openjdk openjdk11 openjdk17 openjdk21 openjdk8-redhat microsoft-jdk maven groovy gradle scala scala-cli sbt
        scoop install --global nvm vulkan fiddler speedtest gimp vlc azuredatastudio azuredatastudio-insiders
        if ($LASTEXITCODE -ne 0) { Write-Host "scoop install --global failed"; throw "Exit code is $LASTEXITCODE" }
        $complete = $true
    } catch [Exception] {
        Write-Host $_.Exception.Message
        Write-Host "Retrying"
    }
} while (-not $complete)

scoop update --all --global
Stop-Service -Force sshd
C:\ProgramData\scoop\apps\openssh\current\install-sshd.ps1
regedit /s C:\ProgramData\scoop\apps\zlib\current\register.reg
# scoop update
scoop update
scoop update --all
scoop update --all --global
scoop status
