*** Test Cases ***
Create User with Default role
    Create User    Bob  secret121!

Create User with Custom Role
    Create User    Bob  secret121!  admin

*** Keywords ***

Create User
    [Arguments]    ${username}    ${password}    ${role}=user
    Log To Console   Creating user ${username} with password ${password} and role ${role}!