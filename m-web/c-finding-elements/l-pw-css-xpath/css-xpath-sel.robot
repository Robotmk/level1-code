*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://todomvc.com/examples/vue/dist/#/

*** Test Cases ***

XPath And CSS Selectors In Action 
    # Highlight the elements below on the todo page!
    # - Input field, identified by the placeholder attribute
    #   (Hint: use the placeholder attribute)
    # - The <h1> headline
    # - The white <aside> area on the left
    #   (Hint: use the class attribute)
    No Operation
    