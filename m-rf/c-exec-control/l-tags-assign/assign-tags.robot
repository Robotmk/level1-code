*** Settings ***
Documentation   Execute with: 
...   robot --settag crm --settag sprint:33 assign-tags.robot
Test Tags       sprint:42    smoke

*** Variables ***
${HOST}         10.0.1.42
${ENVIRONMENT}   TEST

*** Test Cases ***
Test 1
    No Operation

Test 2
    [Tags]    not ready
    No Operation

Test 3
    [Tags]    host:${HOST}    -crm
    No Operation

Test4
    [Tags]    -smoke
    No Operation

Test5
    [Tags]    -sprint:*
    No Operation

Test6
    Set Tags    example    another

Test7
    [Tags]    target:${ENVIRONMENT}    -s*    -crm
    No Operation