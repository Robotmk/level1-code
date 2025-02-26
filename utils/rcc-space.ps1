param (
    [switch]$createOnly,
    [string]$robotPath,
    [switch]$help
)

# Function to display help information
function Show-Help {
    Write-Host "Author: Simon Meggle, mail@robotmk.org"
    Write-Host "Usage: rcc-space.ps1 [-createOnly] [-robotPath <path>] [-help]"
    Write-Host "Options:"
    Write-Host "  -createOnly   Only create the environment without activating it."
    Write-Host "  -robotPath    Specify the path to the robot directory."
    Write-Host "  -help         Display this help information."
    Write-Host "This script activates an environment in a specified space."
    Write-Host "Ensure that both robot.yaml and conda.yaml exist in the specified path."
}

# Call Show-Help if -help is provided or if no parameters are provided
if ($help) {
    Show-Help
    exit
}

# rcc-activate.ps1
# This script activates an environment in a specified space.
# It retrieves the space name from the script's directory and checks for validity.

# Check if RCC_ENVIRONMENT_HASH is set
if ($env:RCC_ENVIRONMENT_HASH) {
    Write-Host "ERROR: The current shell is already inside an activated environment."
    exit 1
}

# Determine spaceName based on robotPath or current directory
if (-not $robotPath) {
    $robotPath = Get-Location
}
$spaceName = Split-Path -Leaf $robotPath  # Update to use robotPath if provided

# Check for the existence of robot.yaml and conda.yaml in robotPath
if (-not (Test-Path "$robotPath\robot.yaml") -or -not (Test-Path "$robotPath\conda.yaml")) {
    Write-Host "ERROR: Both robot.yaml and conda.yaml must exist in $robotPath. Exiting."
    Show-Help
    exit 1
}

# Check if rcc command is available
if (-not (Get-Command rcc -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: rcc command not found. Please install it and try again."
    Show-Help
    exit 1
}

# Check if SPACENAME is not empty
if ([string]::IsNullOrEmpty($spaceName)) {
    Write-Host "ERROR: SPACENAME is empty. Exiting."
    Show-Help
    exit 1
}

Write-Host "Activating environment in space: $spaceName"

# Store current directory
$originalDir = Get-Location


# Update rcc command
if ($createOnly) {
    rcc ht vars --space $spaceName -r "$robotPath\robot.yaml"
} else {
    rcc task shell --space $spaceName -r "$robotPath\robot.yaml"
}


if ($LASTEXITCODE -eq 0) {
    if ($createOnly) {
        Write-Host "OK: Environment in space $spaceName created."
    } else {
        Write-Host "OK: Environment in space $spaceName activated."
    }
    # Change back to original directory
    Set-Location $originalDir
} else {
    Write-Host "Error: Failed to activate environment in space $spaceName."
    exit 1
}
