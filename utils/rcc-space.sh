#!/bin/bash
# This script activates an environment in a specified space.
# It retrieves the space name from the script's directory and checks for validity.

# Set SPACENAME to the current working directory's folder name
SPACENAME=$(basename "$PWD")

# Check if RCC_ENVIRONMENT_HASH is set
if [ -n "$RCC_ENVIRONMENT_HASH" ]; then
    echo "❌ Error: The current shell is already inside an activated environment. Please deactivate it first."
    exit 1
fi

# Check if rcc command is available
if ! command -v rcc &> /dev/null; then
    echo "❌ Error: rcc command not found. Please install it and try again."
    exit 1
fi

# Check if SPACENAME is not empty
if [ -z "$SPACENAME" ]; then
    echo "❌ Error: SPACENAME is empty. Exiting."
    exit 1
fi

# Parse command line options
while getopts ":cd:" opt; do
    case $opt in
        c) create_only=true ;;
        d) ROBOTPATH="$OPTARG" ;;
        *) echo "Invalid option"; exit 1 ;;
    esac
done

# Determine ROBOTPATH if not set
if [ -z "$ROBOTPATH" ]; then
    ROBOTPATH="$PWD"
fi

# Check for the existence of robot.yaml and conda.yaml in ROBOTPATH
if [ ! -f "$ROBOTPATH/robot.yaml" ] || [ ! -f "$ROBOTPATH/conda.yaml" ]; then
    echo "❌ Error: Both robot.yaml and conda.yaml must exist in $ROBOTPATH. Exiting."
    exit 1
fi

echo "Activating environment in space: $SPACENAME"

# Update rcc command
if [ "$create_only" = true ]; then
    rcc ht vars --space "$SPACENAME" -y "$ROBOTPATH/robot.yaml"
else
    rcc task shell --space "$SPACENAME" -y "$ROBOTPATH/robot.yaml"
fi

echo "🟢 Environment in space $SPACENAME activated."