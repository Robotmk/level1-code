*** Settings ***
Library  String

*** Variables ***
${VAR_B}  Hello, res_B!

*** Keywords ***

Keyword B
    Log  "A keyword from res_B.resource"
    Log  SUITE_VAR: ${SUITE_VAR}
    Log  VAR_A: ${VAR_A}
    ${date} =  Get Current Date
    Log  ${date}