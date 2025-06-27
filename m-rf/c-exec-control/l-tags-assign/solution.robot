*** Settings ***
Documentation   Execute with: 
...   robot --settag crm --settag sprint33 assign-tags.robot
Test Tags       sprint42    smoke

*** Variables ***
${HOST}         10.0.1.42

*** Test Cases ***
Test 1
    # crm, sprint33, sprint42, smoke
    No Operation

Test 2
    # crm, sprint33, sprint42, smoke, not_ready
    [Tags]    not_ready
    No Operation

Test 3
    # (A global tag cannot be removed!)
    # crm, sprint33, sprint42, smoke, host_10.0.1.42
    [Tags]    host_${HOST}    -crm
    No Operation

Test4
    # crm, sprint33, sprint42
    [Tags]    -smoke
    No Operation

Test5
    # crm, sprint33
    [Tags]    -s*    -crm
    No Operation