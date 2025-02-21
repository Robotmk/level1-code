@echo off

:: Check current longpath config
echo Checking current longpath configuration...
rcc config longpaths
if %errorLevel% neq 0 (
    echo [ERROR] Longpath support not enabled. 
    echo Please open an Admin cmd.exe and execute longpaths.bat.
    echo After that, retry this script again.
    pause
    exit /b 1
) else (
    echo Longpath support enabled.
)

create-env.bat