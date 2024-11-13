*** Settings ***
Resource   res_B.resource
Library  DateTime

*** Variables ***
${VAR_A}  Hello, res_A!

*** Keywords ***

Keyword A
    Log  "A keyword from res_A.resource"
    ${upper}  Convert To Uppercase  ${VAR_B}
    Log  ${upper}
    Log  VAR_B: ${VAR_B}
