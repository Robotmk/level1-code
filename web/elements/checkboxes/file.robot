*** Settings ***
Library     Browser

*** Test Cases ***
Fill In Search On Playwright
    New Browser    headless=False
    New Context    locale=en-US
    New Page    url=https://the-internet.herokuapp.com/checkboxes
    ${option1_enabled}=  Get Checkbox State   input:nth-of-type(1)
    ${option2_enabled}=  Get Checkbox State   input:nth-of-type(2)

    Sleep  1
    Check Checkbox  input:nth-of-type(1)
    Sleep  1
    Uncheck Checkbox  input:nth-of-type(2)
    Sleep  2