*** Settings ***
Resource   lib-Browser.resource


*** Keywords ***

Browser Initialization
    [Arguments]  ${url}
    New Browser  headless=False
    New Context    locale=en-US
    # Open the RF page
    New Page    ${url}