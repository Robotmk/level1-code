
:: Check for required files
if not exist "conda.yaml" (
    echo [ERROR] Missing file: conda.yaml
    echo Make sure this script is executed in the correct directory.
    pause
    exit /b 1
)

if not exist "robot.yaml" (
    echo [ERROR] Missing file: robot.yaml
    echo Make sure this script is executed in the correct directory.
    exit /b 1
)

:: Execute RCC commands
echo Disabling telemetry
rcc configure identity -t


:: Run final command and check success
echo Creating the test environment...
rcc holotree vars
if %errorLevel% neq 0 (
    echo [ERROR] Failed to create the test environment.
    exit /b 1
)

echo.
echo [SUCCESS] RCC has been configured successfully!
pause
exit /b 0