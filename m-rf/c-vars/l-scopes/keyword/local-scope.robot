*** Settings ***
Documentation    This suite demonstrates the use of local variables.

*** Test Cases ***
Create and Log User
    @{car}=    Get The Car
    Log The Car  ${car}

*** Keywords ***
Get The Car
    VAR  ${brand}     BMW
    VAR  ${color}     blue
    RETURN    ${brand}  ${color}

Log The Car
    [Arguments]    ${car} 
    Log          The car is a ${car}[1] ${car}[0].
    Log Many     List contains:  @{car}