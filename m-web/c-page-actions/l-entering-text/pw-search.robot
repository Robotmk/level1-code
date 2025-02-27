*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://playwright.dev


*** Test Cases ***
Quick Search On Playwright
    No Operation
    # Click the Search Button
    # Enter "download" into the search field
    # Send a keyboard signal "press Enter"

Delayed Search On Playwright
    No Operation
    # Click the Search Button
    # Enter "download" into the search field, key by key, 400ms delay
    # Send the Enter key event
