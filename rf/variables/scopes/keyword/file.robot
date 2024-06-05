*** Test Cases ***
Create and Log User
    ${data}=    Generate User Details
    Log Many  @{data}

*** Keywords ***
Generate User Details
    ${username}=    Set Variable    robot_user
    ${password}=    Set Variable    securePass123
    Log A Local Variable  ${username}
    RETURN    ${username}    ${password}

Log A Local Variable
    [Arguments]    ${txt} 
    Log    Username is: ${txt}