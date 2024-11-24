*** Settings ***
Documentation    This suite demonstrates the use of local variables.

*** Test Cases ***
Create and Log User
    ${userdata}=    Generate User Details
    Log A Local Variable  ${userdata}

*** Keywords ***
Generate User Details
    VAR  ${username}  robot_user
    VAR  ${password}  securePass123
    RETURN    ${username}    ${password}

Log A Local Variable
    [Arguments]    ${data} 
    Log          User data are:
    Log Many     @{data}