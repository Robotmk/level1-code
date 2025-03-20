*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://iframe.robotmk.org

*** Test Cases ***

Highlight ELABIT Logo
    Highlight Elements  iframe >>> a.sponsor[href*='elabit']
    