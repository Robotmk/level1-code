*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://todomvc.com/examples/vue/dist/#/

*** Test Cases ***

XPath And CSS Selectors In Action 
    #### Task 1 
    # Using a CSS selector (implicit)
    Highlight Elements  input[placeholder*='What needs to be done']
    # explicit use of CSS with css=
    Highlight Elements  css=input[placeholder*='What needs to be done']
    #### Task 2
    # Using a XPath selector (starts with /)
    Highlight Elements  //h1
    # explicit use of XPath
    Highlight Elements  xpath=//h1
    #### Task 3
    Highlight Elements  aside.learn   # CSS
    Highlight Elements  //aside[@class='learn']   # XPath