*** Settings ***
Resource   lib-Browser.resource

*** Keywords ***

Browser Initialization
    [Arguments]  ${url}
    New Browser  headless=False
    New Context    locale=en-US
    New Page    ${url}

Browser Init
    New Browser  headless=False

Session Init
    [Arguments]  ${url}
    New Context    locale=en-US
    New Page    ${url}