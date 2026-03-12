*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://the-internet.herokuapp.com/checkboxes
${SEL_OPTION2}  //input[2]

*** Test Cases ***
Toggle Checkbox
    No Operation
    # Read the status of the second checkbox (use the selector from the Variables section)
    # activate it, if unchecked. 
    # deactivate it, if checked. 