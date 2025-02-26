*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://www.globalsqa.com/demo-site/frames-and-windows/#iFrame

*** Test Cases ***

Search VIM Cheat Sheet
    # Accept Cookies
    Click  div.fc-dialog >> button >> "Consent"
    
    # Inside the iframe page, search for "vim"

    # Verify that the first search result shows the VIM cheat sheet:
    Get Text  ol.search_res >> li:first-of-type  *=  VIM Cheat Sheet (page)