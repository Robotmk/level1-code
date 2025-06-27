*** Test Cases ***
Test A
    # Use the keyword Create User to create a user ‘Bob’ with password ‘secret121!’, 
    # without a specific role. Use only positional args.
    # =>

Test B
    # Create the same user as in A, with the role admin.
    # =>

Test C
    # Create the same user as in B, pass the arguments in the order 1. password, 2. role, 3.
    # =>

*** Keywords ***

Create User
    [Arguments]    ${username}    ${password}    ${role}=user
    Log To Console   Creating user ${username} with password ${password} and role ${role}!