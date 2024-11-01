# rcc-activate.ps1
# This script activates an environment in a specified space.
# It retrieves the space name from the script's directory and checks for validity.

# Check if RCC_ENVIRONMENT_HASH is set
if ($env:RCC_ENVIRONMENT_HASH) {
    Write-Host "Error: The current shell is already inside an activated environment."
    exit 1
}

$scriptDir = Get-Location
$spaceName = Split-Path -Leaf $scriptDir

# Check if rcc command is available
if (-not (Get-Command rcc -ErrorAction SilentlyContinue)) {
    Write-Host "Error: rcc command not found. Please install it and try again."
    exit 1
}

# Check if SPACENAME is not empty
if ([string]::IsNullOrEmpty($spaceName)) {
    Write-Host "Error: SPACENAME is empty. Exiting."
    exit 1
}

# Check for the existence of robot.yaml and conda.yaml
if (-not (Test-Path "$scriptDir\robot.yaml")) {
    Write-Host "Error: robot.yaml not found in the directory. Exiting."
    exit 1
}

if (-not (Test-Path "$scriptDir\conda.yaml")) {
    Write-Host "Error: conda.yaml not found in the directory. Exiting."
    exit 1
}

Write-Host "Activating environment in space: $spaceName"

rcc task shell --space $spaceName

Write-Host "🟢 Environment in space $spaceName activated."
