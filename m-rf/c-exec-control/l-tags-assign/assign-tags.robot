*** Settings ***
Test Tags       requirement: 42    smoke

*** Variables ***
${HOST}         10.0.1.42
${ENVIRONMENT}   TEST

*** Test Cases ***
No own tags
    No Operation

Own tags
    [Tags]    not ready
    No Operation

Own tags with variable
    [Tags]    host: ${HOST}
    No Operation

Remove common tag
    [Tags]    -smoke
    No Operation

Remove common tag using a pattern
    [Tags]    -requirement: *
    No Operation

Set Tags and Remove Tags keywords
    Set Tags    example    another
    Remove Tags    requirement: *

Set Tag With Environment Variable
    [Tags]    environment:${ENVIRONMENT}
    No Operation