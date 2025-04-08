*** Settings ***
Documentation   Execute with: 
...   robot --settag crm --settag sprint:33 assign-tags.robot
Test Tags       sprint:42    smoke

*** Variables ***
${HOST}         10.0.1.42
${ENVIRONMENT}   TEST

*** Test Cases ***
Test 1
    # crm, smoke, sprint:33, sprint:42
    No Operation

Test 2
    # crm, smoke, sprint:33, sprint:42, not ready
    [Tags]    not ready
    No Operation

Test 3
    # (A global tag cannot be removed!)
    # crm, host:10.0.1.42, smoke, sprint:33, sprint:42
    [Tags]    host:${HOST}    -crm
    No Operation

Test4
    # crm, sprint:33, sprint:42
    [Tags]    -smoke
    No Operation

Test5
    # (spring:33 is a  global tag an cannot be removed!)
    # crm, smoke, sprint:33
    [Tags]    -sprint:*
    No Operation

Test6
    # crm, sprint:33, smoke, sprint:42, example, another
    Set Tags    example    another

Test7
    # crm, sprint:33, target:TEST
    [Tags]    target:${ENVIRONMENT}    -s*    -crm
    No Operation