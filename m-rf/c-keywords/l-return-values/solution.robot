*** Settings ***
Documentation  Demonstrate the usage of the RETURN statement.

*** Variables ***
${EXPECTED_RESULT}  ${14}

*** Test Cases ***
My Test
    ${numbers}=  Return Three Values
    ${result} =  Sum Of  @{numbers}
    Should Be Equal  ${result}  ${EXPECTED_RESULT}
*** Keywords ***

Sum Of
    [Arguments]  ${a}  ${b}  ${c}
    ${sum}=  Evaluate  ${a} + ${b} + ${c}
    RETURN  ${sum}

Return Three Values
    RETURN    2    4    8