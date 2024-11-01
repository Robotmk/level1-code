#!/bin/bash
# This script activates an environment in a specified space.
# It retrieves the space name from the script's directory and checks for validity.

if [ -n "$RCC_ENVIRONMENT_HASH" ]; then
    echo "❌ Error: The current shell is already inside an activated environment. Please deactivate it first."
    exit 1
fi

if ! command -v rcc &> /dev/null; then
    echo "❌ Error: rcc command not found. Please install it and try again."
    exit 1
fi

function display_help() {
    echo "$0 [-c] [-d <path>] [-h]"
    echo "Author: Simon Meggle, mail@robotmk.org"
    echo "Usage: rcc-space.sh [options]"
    echo
    echo "Options:"
    echo "  -c                Create environment only."
    echo "  -d <path>         Specify the ROBOTPATH."
    echo "  -h                Display this help message."
    echo
    echo "This script activates an environment in a specified space."
    echo "robot.yaml and conda.yaml have to be present in the specified ROBOTPATH or cwd."
}

while getopts ":cd:h" opt; do
    case $opt in
        c) create_only=true ;;
        d) ROBOTPATH="$OPTARG" ;;
        h) display_help; exit 0 ;;  
        *) echo "❌ ERROR: Invalid option"; display_help; exit 1 ;;
    esac
done

if [ -z "$ROBOTPATH" ]; then
    SPACENAME=$(basename "$PWD")  
else
    SPACENAME=$(basename "$ROBOTPATH")  
fi


if [ -z "$ROBOTPATH" ]; then
    ROBOTPATH="$PWD"
fi

if [ -z "$SPACENAME" ]; then
    echo "❌ Error: SPACENAME is empty. Exiting."
    exit 1
fi

if [ ! -f "$ROBOTPATH/robot.yaml" ] || [ ! -f "$ROBOTPATH/conda.yaml" ]; then
    echo "❌ Error: Both robot.yaml and conda.yaml must exist in $ROBOTPATH. Exiting."
    exit 1
fi

echo "Activating environment in space: $SPACENAME"

if [ "$create_only" = true ]; then
    rcc ht vars --space "$SPACENAME" -r "$ROBOTPATH/robot.yaml"
else
    rcc task shell --space "$SPACENAME" -r "$ROBOTPATH/robot.yaml"
fi

if [ $? -eq 0 ]; then
    if [ "$create_only" = true ]; then
        echo "🟢 Environment in space $SPACENAME created."
    fi
else
    echo "❌ Error: Failed to activate environment in space $SPACENAME."
    exit 1
fi
