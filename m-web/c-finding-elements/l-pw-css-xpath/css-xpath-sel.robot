*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://todomvc.com/examples/vue/dist/#/

*** Test Cases ***

XPath And CSS Selectors In Action 
    # Using a CSS selector (implicit)
    Highlight Elements  input[placeholder*='What needs to be done']
    # explicit use of CSS with css=
    Highlight Elements  css=input[placeholder*='What needs to be done']
    # Using a XPath selector (starts with /)
    Highlight Elements  //h1
    # explicit use of XPath
    Highlight Elements  xpath=//h1