*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://iframe.robotmk.org

*** Test Cases ***

Highlight ELABIT Logo
    # Highlight the ELABIT link inside of the iframe!
    No Operation
    