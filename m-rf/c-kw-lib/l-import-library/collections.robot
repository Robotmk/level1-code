*** Settings ***
Library    Collections
Documentation    This is a test suite which shows the usage of Collections library.

*** Test Cases ***
Example with Collections
    ${list}    Create List    Apple    Banana    Cherry  Banana
    Length Should Be    ${list}    4
    Should Contain    ${list}    Banana
    Should Contain X Times   ${list}    Banana    2