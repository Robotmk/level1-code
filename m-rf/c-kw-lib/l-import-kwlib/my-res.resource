*** Settings ***
Library  String

*** Variables ***
${MYVAR}  Hello, World!

*** Keywords ***

Keyword A
    ${MYVAR_UPPER}  Convert To Uppercase  ${MYVAR}
    Log  ${MYVAR_UPPER}

Keyword B
    No Operation