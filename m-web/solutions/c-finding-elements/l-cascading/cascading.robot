*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://sweetshop.netlify.app/sweets

*** Test Cases ***

Highlight Rainbow Dust Sweet 
    # Highlight the div with class 'card' which contains a sweet 
    # whose name begins with "Rainbow Dust"
    Highlight Elements  *css=div.card >> //p[starts-with(text(),'Rainbow Dust')]
    Highlight Elements  *css=div.card >> text=/^Rainbow Dust.*/