*** Settings ***
Resource          lib-browser.resource

*** Keywords ***
Login As User
    [Arguments]    ${email}    ${password}    ${name}
    No Operation
    # => 