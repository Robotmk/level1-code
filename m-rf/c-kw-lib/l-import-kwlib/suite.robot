*** Settings ***
Documentation  A Suite with an external resource file
Resource  res_A.resource

*** Variables ***
${SUITE_VAR}  Hello, Suite!

*** Test Cases ***
Test 1
    Keyword A
    Keyword B