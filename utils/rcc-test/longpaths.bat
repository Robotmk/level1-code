@echo off
setlocal enabledelayedexpansion

:: Check if the script is running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] This script must be run as Administrator!
    echo Right-click on this script and select 'Run as administrator'.
    exit /b 1
)


:: Check current longpath config
echo Checking current longpath configuration...
rcc config longpaths
if %errorLevel% neq 0 (
    echo [ERROR] Longpath support not enabled. 
    echo Please open an Admin cmd.exe and execute this script again.
    pause
    exit /b 1
)

:: Enable longpath support
echo Enabling longpath support...
rcc config longpaths --enable
if %errorLevel% neq 0 (
    echo [ERROR] Failed to enable longpath support.
    pause
    exit /b 1
)

:: Success message
echo [OK] Longpath support enabled successfully!
pause
exit /b 0