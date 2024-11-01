#!/bin/bash
# This script activates an environment in a specified space.
# It retrieves the space name from the script's directory and checks for validity.

SPACENAME=$(basename "$(dirname "$0")")

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
if [ ! -f "$(dirname "$0")/robot.yaml" ]; then
    echo "Error: robot.yaml not found in the directory. Exiting."
    exit 1
fi

if [ ! -f "$(dirname "$0")/conda.yaml" ]; then
    echo "Error: conda.yaml not found in the directory. Exiting."
    exit 1
fi

rcc task shell --space "$SPACENAME"