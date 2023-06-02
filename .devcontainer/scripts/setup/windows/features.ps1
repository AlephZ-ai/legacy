Write-Host "setup/windows/features.ps1"
$ProgPref = $ProgressPreference
$ProgressPreference = 'SilentlyContinue'
$results = Enable-WindowsOptionalFeature -FeatureName TFTP,LegacyComponents,DirectPlay,MediaPlayback,SmbDirect,MSRDC-Infrastructure,MicrosoftWindowsPowerShellV2Root, `
  MicrosoftWindowsPowerShellV2,SearchEngine-Client-Package,Printing-PrintToPDFServices-Features,Printing-XPSServices-Features,TelnetClient,Printing-Foundation-InternetPrinting-Client, `
  HypervisorPlatform,Microsoft-Hyper-V-All,Microsoft-Hyper-V-Tools-All,VirtualMachinePlatform,Containers-DisposableClientVM `
  -All -Online -NoRestart -WarningAction SilentlyContinue | Write-Host
$ProgressPreference = $ProgPref
if ($results.RestartNeeded -eq $true) {
  do { $key = Read-Host "Press 'Y' to reboot your computer and don't forget to restart the script after reboot" } while ($key -ne 'Y' -and $key -ne 'y')
  Restart-Computer -Force | Write-Host
}

Add-WindowsCapability -Online -Name "App.StepsRecorder" | Write-Host
Add-WindowsCapability -Online -Name "App.Support.QuickAssist" | Write-Host
Add-WindowsCapability -Online -Name "App.WirelessDisplay.Connect" | Write-Host
Add-WindowsCapability -Online -Name "DirectX.Configuration.Database" | Write-Host
Add-WindowsCapability -Online -Name "Language.Basic~~~en-US" | Write-Host
Add-WindowsCapability -Online -Name "Language.Handwriting~~~en-US" | Write-Host
Add-WindowsCapability -Online -Name "Language.OCR~~~en-US" | Write-Host
Add-WindowsCapability -Online -Name "Language.Speech~~~en-US" | Write-Host
Add-WindowsCapability -Online -Name "Language.TextToSpeech~~~en-US" | Write-Host
Add-WindowsCapability -Online -Name "MathRecognizer" | Write-Host
Add-WindowsCapability -Online -Name "Microsoft.WebDriver" | Write-Host
Add-WindowsCapability -Online -Name "Microsoft.Windows.MSPaint" | Write-Host
Add-WindowsCapability -Online -Name "Microsoft.Windows.Notepad" | Write-Host
Add-WindowsCapability -Online -Name "Microsoft.Windows.PowerShell.ISE" | Write-Host
Add-WindowsCapability -Online -Name "Microsoft.Windows.WordPad" | Write-Host
Add-WindowsCapability -Online -Name "Msix.PackagingTool.Driver" | Write-Host
Add-WindowsCapability -Online -Name "OpenSSH.Client" | Write-Host
Add-WindowsCapability -Online -Name "OpenSSH.Server" | Write-Host
Add-WindowsCapability -Online -Name "Print.Fax.Scan" | Write-Host
Add-WindowsCapability -Online -Name "Print.Management.Console" | Write-Host
Add-WindowsCapability -Online -Name "RasCMAK.Client" | Write-Host
Add-WindowsCapability -Online -Name "RIP.Listener" | Write-Host
Add-WindowsCapability -Online -Name "SNMP.Client" | Write-Host
Add-WindowsCapability -Online -Name "Tools.DeveloperMode.Core" | Write-Host
Add-WindowsCapability -Online -Name "Tools.Graphics.DirectX" | Write-Host
Add-WindowsCapability -Online -Name "WMI-SNMP-Provider.Client" | Write-Host
Add-WindowsCapability -Online -Name "XPS.Viewer" | Write-Host
