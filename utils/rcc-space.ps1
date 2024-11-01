param (
    [switch]$createOnly,
    [string]$robotPath
)

# rcc-activate.ps1
# This script activates an environment in a specified space.
# It retrieves the space name from the script's directory and checks for validity.

# Check if RCC_ENVIRONMENT_HASH is set
if ($env:RCC_ENVIRONMENT_HASH) {
    Write-Host "ERROR: The current shell is already inside an activated environment."
    exit 1
}

$scriptDir = Get-Location
$spaceName = Split-Path -Leaf $scriptDir

# Determine robotPath if not set
if (-not $robotPath) {
    $robotPath = Get-Location
}

# Check for the existence of robot.yaml and conda.yaml in robotPath
if (-not (Test-Path "$robotPath\robot.yaml") -or -not (Test-Path "$robotPath\conda.yaml")) {
    Write-Host "ERROR: Both robot.yaml and conda.yaml must exist in $robotPath. Exiting."
    exit 1
}

# Check if rcc command is available
if (-not (Get-Command rcc -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: rcc command not found. Please install it and try again."
    exit 1
}

# Check if SPACENAME is not empty
if ([string]::IsNullOrEmpty($spaceName)) {
    Write-Host "ERROR: SPACENAME is empty. Exiting."
    exit 1
}

Write-Host "Activating environment in space: $spaceName"

# Update rcc command
if ($createOnly) {
    rcc ht vars --space $spaceName -y "$robotPath\robot.yaml"
} else {
    rcc task shell --space $spaceName -y "$robotPath\robot.yaml"
}

Write-Host "OK: Environment in space $spaceName activated."
