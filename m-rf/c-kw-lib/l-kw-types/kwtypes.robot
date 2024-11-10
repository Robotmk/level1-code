*** Settings ***
Documentation      This suite demonstrates the usage of library/user keywords in Robot Framework.

*** Test Cases ***

Test 1
    Keyword C
    Keyword D

*** Keywords ***

Keyword A
    No Operation
    Log  'No Operation' is the dumbest keyword ever. 

Keyword B
    Should Be True    ${TRUE}
    Log  Surprise, it's true! 😉

Keyword C
    Keyword A
    Keyword B

Keyword D
    Log  I am Keyword D.