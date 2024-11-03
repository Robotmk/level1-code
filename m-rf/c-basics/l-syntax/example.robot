*** Settings ***
Documentation     Example suite showing the basic syntax.
Library           OperatingSystem
Library           Collections

*** Variables ***
${MESSAGE}        Hello, world!
${MY_LIST}        item1    item2    item3

*** Test Cases ***
My Test
    [Documentation]    Example test demonstrating logging and custom keywords.
    Log    ${MESSAGE}
    My Keyword    ${CURDIR}
    Length Should Be    ${MY_LIST}    3

Another Test
    [Documentation]    Testing equality assertion.
    Should Be Equal    ${MESSAGE}    Hello, world!
    Log Many    ${MY_LIST}

*** Keywords ***
My Keyword
    [Arguments]    ${path}
    Directory Should Exist    ${path}

Log Many
    [Arguments]    @{items}
    FOR    ${item}    IN    @{items}
        Log    ${item}
    END