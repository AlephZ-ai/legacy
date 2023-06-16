@echo off
set projectRoot=%~dp0
set scriptPath=%1
set script=%2
set commandPath=%3
set command=%4
set "scriptsRoot=%projectRoot%/.devcontainer/scripts"
for /F "tokens=1* delims==" %%A IN ('call "%scriptsRoot%/setup/environment.cmd"') do set "%%A=%%B"
PowerShell -file "%LEGACY_PROJECT_ROOT%/run.ps1" --scriptPath "%scriptPath%" --script "%script%" --commandPath "%commandPath%" --command "%command%"
