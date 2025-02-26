*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://the-internet.herokuapp.com/checkboxes
${SEL_OPTION2}  input:nth-of-type(2)

*** Test Cases ***
Toggle Checkbox
    No Operation
    # Read the status of the second checkbox
    # activate it, if unchecked. 
    # deactivate it, if checked. 