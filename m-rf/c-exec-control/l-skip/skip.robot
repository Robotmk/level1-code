*** Settings ***
Documentation    This suite demonstrates the use of tags to skip test cases. 

*** Variables ***
${SKIP_FLAG}    False

*** Test Cases ***
Test One
    Log  Test One was executed.
    VAR  ${SKIP_FLAG}  True  scope=suite

Test two
    Skip If  ${SKIP_FLAG}
    Log  Test Two was executed.

Test three
    [Tags]  robot:skip
    Skip If  ${SKIP_FLAG}
    Log  Test Two was executed.