*** Test Cases ***
Create and Log User
    ${data}=    Generate User Details
    Log To Console    Username: ${data}[0]
    Log To Console    Password: ${data}[1]
    Log Many  @{data}

*** Keywords ***
Generate User Details
    ${username}=    Set Variable    robot_user
    ${password}=    Set Variable    securePass123
    RETURN    ${username}    ${password}