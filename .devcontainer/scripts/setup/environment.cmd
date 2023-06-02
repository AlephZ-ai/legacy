@echo off
setlocal EnableDelayedExpansion
set cmdDir=%~dp0
for %%i in ("%cmdDir%\..") do for %%j in ("%%~fi") do set "scriptsRoot=%%~fj"
for %%i in ("%scriptsRoot%\..") do for %%j in ("%%~fi") do set "devcontainerRoot=%%~fj"
for %%i in ("%devcontainerRoot%\..") do for %%j in ("%%~fi") do set "projectRoot=%%~fj"
pushd %devcontainerRoot%
for /F "tokens=1,2 delims==" %%a in ('type .env') do set "%%a=%%b"
popd
set "DEVCONTAINER_FEATURES_PROJECT_ROOT=%projectRoot%"
set "DEVCONTAINER_FEATURES_SOURCE_ROOT=%DEVCONTAINER_FEATURES_PROJECT_ROOT%\src"
set "DEVCONTAINER_SCRIPTS_ROOT=%DEVCONTAINER_FEATURES_PROJECT_ROOT%\.devcontainer\scripts"
for /f "delims=" %%i in ('wsl echo $DISPLAY') do set "DISPLAY=%%i"
if errorlevel 1 (
    echo WSL not found
    exit /b
)

set "LIB_WSL=/usr/lib/wsl"
for /f "delims=" %%i in ('wsl --distribution Ubuntu echo $XDG_RUNTIME_DIR') do set "XDG_RUNTIME_DIR=%%i"
if errorlevel 1 (
    echo Ubuntu WSLg distribution not found
    for /f "delims=" %%i in ('wsl echo $XDG_RUNTIME_DIR') do set "XDG_RUNTIME_DIR=%%i"
)

if not "%DISPLAY%"=="" (
    set "MNT_WSLG=/mnt/wslg"
    set "X11_SOCKET=/tmp/.X11-unix"
    for /f "delims=" %%i in ('wsl echo $WAYLAND_DISPLAY') do set "WAYLAND_DISPLAY=%%i"
    for /f "delims=" %%i in ('wsl echo $PULSE_SERVER') do set "PULSE_SERVER=%%i"
) else (
    echo WSLg not found
)

set
endlocal
