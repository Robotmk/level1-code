*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://sweetshop.netlify.app/sweets

*** Test Cases ***

Highlight Rainbow Dust Sweet 
    # Use "cascaded selectors" (https://marketsquare.github.io/robotframework-browser/Browser.html#Finding%20elements)
    # to highlight the div with class 'card' 
    # which contains a sweet whose name begins with "Rainbow Dust".
    
    # option 1: using CSS with XPath's "starts-with"
    Highlight Elements  *css=div.card >> //p[starts-with(text(),'Rainbow Dust')]
    # option 2: using CSS with text (regex)
    Highlight Elements  *css=div.card >> text=/^Rainbow Dust.*/
    # option 3: using CSS with XPath's "contains" 
    Highlight Elements  *css=div.card >> //p[contains(text(),'Rainbow Dust')]