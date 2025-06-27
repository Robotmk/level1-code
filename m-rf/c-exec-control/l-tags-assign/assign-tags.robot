*** Settings ***
Documentation   Execute with: 
...   robot --settag crm --settag sprint33 assign-tags.robot
Test Tags       sprint42    smoke

*** Variables ***
${HOST}         10.0.1.42

*** Test Cases ***
Test 1
    No Operation

Test 2
    [Tags]    not_ready
    No Operation

Test 3
    [Tags]    host_${HOST}    -crm
    No Operation

Test4
    [Tags]    -smoke
    No Operation

Test5
    [Tags]    -s*    -crm
    No Operation