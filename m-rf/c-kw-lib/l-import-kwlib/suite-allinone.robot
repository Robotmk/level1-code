*** Settings ***
Documentation  A Suite with everything defined in one file
Library  String

*** Variables ***
${MYVAR}  Hello, World!
*** Test Cases ***
Test 1
    Keyword A
    Keyword B

*** Keywords ***

Keyword A
    ${MYVAR_UPPER}  Convert To Uppercase  ${MYVAR}
    Log  ${MYVAR_UPPER}

Keyword B
    No Operation