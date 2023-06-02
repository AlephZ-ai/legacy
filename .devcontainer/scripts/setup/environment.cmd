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
for /f "delims=" %%i in ('wsl echo $DISPLAY') do set "wd=%%i"
if errorlevel 1 (
    echo WSL not found
    exit /b
)

set "LIB_WSL=/usr/lib/wsl"
if not "%wd%"=="" (
    set "MNT_WSLG=/mnt/wslg"
    set "X11_SOCKET=/tmp/.X11-unix"
) else (
    echo WSLg not found
)

set
endlocal
