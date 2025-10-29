*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://iframe.robotmk.org

*** Test Cases ***

Highlight ELABIT Logo
    # Approach 1: use the href attribute of the "elabit" link
    Highlight Elements  iframe[name='rf-home'] >>> a.sponsor[href*='elabit']
    # Approach 2: use the image link in the style attribute (contains "elabit.png")
    Highlight Elements  iframe[name='rf-home'] >>> div[style*='elabit.png']
    