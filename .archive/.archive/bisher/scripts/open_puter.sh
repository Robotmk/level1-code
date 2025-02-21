#!/bin/bash

# Check if browser name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <browser-name> (chrome|firefox)"
    exit 1
fi

BROWSER=$1
URL="http://puter.robotmk.org"

case $BROWSER in
    chrome)
        # Start Chrome in a maximized window
        google-chrome --start-maximized "$URL" &> /dev/null &
        ;;
    firefox)
        # Start Firefox in a maximized window
        firefox --start-maximized "$URL" &> /dev/null &
        ;;
    *)
        echo "Unsupported browser: $BROWSER"
        echo "Supported browsers: chrome, firefox"
        exit 1
        ;;
esac