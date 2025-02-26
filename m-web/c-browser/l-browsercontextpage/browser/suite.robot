*** Settings ***
# Import the Browser Library
Library  Browser

*** Test Cases ***
A New Browser
    # Create a new browser instance with defaults (headless, Chromium)
    # (https://marketsquare.github.io/robotframework-browser/Browser.html#New%20Browser)
    New Browser

A New Visible Browser
    # Create a new Firefox instance with visible UI
    New Browser  browser=firefox  headless=False
