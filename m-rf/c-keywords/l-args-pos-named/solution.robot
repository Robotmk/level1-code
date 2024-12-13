*** Test Cases ***
Test A
    Create User    Bob  secret121!

Test B
    Create User    Bob  secret121!  admin

Test C
    Create User    password=secret121!  role=admin  username=Bob

*** Keywords ***
Create User
    [Arguments]    ${username}    ${password}    ${role}=user
    Log To Console   Creating user ${username} with password ${password} and role ${role}!