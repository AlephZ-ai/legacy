@echo off
setlocal EnableDelayedExpansion
set cmdDir=%~dp0
for %%i in ("%cmdDir%\..") do for %%j in ("%%~fi") do set "scriptsRoot=%%~fj"
for %%i in ("%scriptsRoot%\..") do for %%j in ("%%~fi") do set "devcontainerRoot=%%~fj"
for %%i in ("%devcontainerRoot%\..") do for %%j in ("%%~fi") do set "projectRoot=%%~fj"
pushd %devcontainerRoot%
for /F "tokens=*" %%i in ('type .env') do set %%i
popd
set "DEVCONTAINER_FEATURES_PROJECT_ROOT=%projectRoot%"
set "DEVCONTAINER_FEATURES_SOURCE_ROOT=%DEVCONTAINER_FEATURES_PROJECT_ROOT%\src"
set "DEVCONTAINER_SCRIPTS_ROOT=%DEVCONTAINER_FEATURES_PROJECT_ROOT%\.devcontainer\scripts"
rem Check if GITHUB_TOKEN or GITHUB_USERNAME is not set
if not defined GITHUB_TOKEN if not defined GITHUB_USERNAME (
    rem Check if GitHub CLI is authenticated
    gh auth status >nul 2>&1
    if %errorlevel% NEQ 0 (
        echo GitHub CLI is not authenticated. Please authenticate using 'gh auth login'.
        exit /b
    )

    rem Check if GITHUB_TOKEN is not set
    if not defined GITHUB_TOKEN (
        rem Get GitHub token
        for /F "tokens=*" %%i IN ('gh auth token') do set GITHUB_TOKEN=%%i
    )
    
    rem Check if GITHUB_USERNAME is not set
    if not defined GITHUB_USERNAME (
        rem Get GitHub username
        for /F "tokens=*" %%i IN ('gh api user --jq .login') do set GITHUB_USERNAME=%%i
    )
)

set
endlocal
