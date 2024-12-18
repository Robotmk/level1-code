*** Test Cases ***
Test A
    No Operation

Test B
    No Operation

Test C
    No Operation

*** Keywords ***

Create User
    [Arguments]    ${username}    ${password}    ${role}=user
    Log To Console   Creating user ${username} with password ${password} and role ${role}!