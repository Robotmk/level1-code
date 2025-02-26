*** Settings ***
Resource   lib-Browser.resource


*** Keywords ***

Browser Initialization
    [Arguments]  ${url}
    New Browser  headless=False  slowMo=1s
    New Context    locale=en-US
    New Page    ${url}

Browser Init
    New Browser  headless=False  slowMo=1s

Session Init
    [Arguments]  ${url}
    New Context    locale=en-US
    New Page    ${url}