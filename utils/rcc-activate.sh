#!/bin/bash
# This script activates an environment in a specified space.
# It retrieves the space name from the script's directory and checks for validity.

# Set SPACENAME to the current working directory's folder name
SPACENAME=$(basename "$PWD")

# Check if RCC_ENVIRONMENT_HASH is set
if [ -n "$RCC_ENVIRONMENT_HASH" ]; then
    echo "Error: The current shell is already inside an activated environment. Please deactivate it first."
    exit 1
fi

# Check if rcc command is available
if ! command -v rcc &> /dev/null; then
    echo "Error: rcc command not found. Please install it and try again."
    exit 1
fi

# Check if SPACENAME is not empty
if [ -z "$SPACENAME" ]; then
    echo "Error: SPACENAME is empty. Exiting."
    exit 1
fi

# Check for the existence of robot.yaml and conda.yaml
if [ ! -f "./robot.yaml" ]; then
    echo "Error: robot.yaml not found in the current working directory. Exiting."
    exit 1
fi

if [ ! -f "./conda.yaml" ]; then
    echo "Error: conda.yaml not found in the current working directory. Exiting."
    exit 1
fi

echo "Activating environment in space: $SPACENAME"

rcc task shell --space "$SPACENAME"

echo "🟢 Environment in space $SPACENAME activated."