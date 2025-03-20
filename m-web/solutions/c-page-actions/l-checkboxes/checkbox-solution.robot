*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://the-internet.herokuapp.com/checkboxes
${SEL_OPTION2}  input:nth-of-type(2)

*** Test Cases ***
Toggle Checkbox
    ${option2_enabled}=  Get Checkbox State   ${SEL_OPTION2}
    IF  ${option2_enabled} == True
        Uncheck Checkbox  ${SEL_OPTION2}
    ELSE
        Check Checkbox  ${SEL_OPTION2}
    END