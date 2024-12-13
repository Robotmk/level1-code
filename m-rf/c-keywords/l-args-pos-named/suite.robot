*** Test Cases ***
Create User with Default role
    No Operation

Create User with Custom Role
    No Operation

*** Keywords ***

Create User
    [Arguments]    ${username}    ${password}    ${role}=user
    Log To Console   Creating user ${username} with password ${password} and role ${role}!