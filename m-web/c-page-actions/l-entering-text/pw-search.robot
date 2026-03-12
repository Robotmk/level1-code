*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Init
Test Setup  Session Init  ${URL}

*** Variables ***
${URL}  https://playwright.dev

*** Test Cases ***
Quick Search On Playwright
    No Operation
    # Click the Search Button 
    # Fill the text field with "download" at once
    # Use "Keyboard key" to press Enter
    
Delayed Search On Playwright
    No Operation
    # Press Ctrl+K to open the search field
    # Enter "download" into the search field (key by key, with 400ms delay)
    # Use "Press Keys" to send the "Enter" key to the input field
