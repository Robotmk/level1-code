*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://todomvc.com/examples/vue/dist/#/

*** Test Cases ***

Test One 
    # Using a CSS selector (implicit)
    Highlight Elements  input[placeholder*='What needs to be done']
    # explicit use of CSS with css=
    Highlight Elements  css=input[placeholder*='What needs to be done']
    # Using a XPath selector (starts with /)
    Highlight Elements  //h1
    # explicit use of XPath
    Highlight Elements  xpath=//h1