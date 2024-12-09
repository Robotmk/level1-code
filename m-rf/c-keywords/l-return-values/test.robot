*** Settings ***
Documentation  Demonstrate the usage of the RETURN statement.

*** Test Cases ***
My Test
    ${numbers}=  Return Three Values
    ${result} =  Sum Of  @{numbers}
    Should Be Equal  ${result}  ${14}
*** Keywords ***

Sum Of
    [Arguments]  ${a}  ${b}  ${c}
    ${sum}=  Evaluate  ${a} + ${b} + ${c}
    RETURN  ${sum}

Return Three Values
    RETURN    2    4    8