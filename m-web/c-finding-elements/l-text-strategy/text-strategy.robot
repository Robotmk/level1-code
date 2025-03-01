*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://todomvc.com/examples/vue/dist/#/

*** Test Cases ***

Test One 
    No Operation