*** Settings ***
Documentation  Demonstrate the usage of the RETURN statement.

*** Variables ***
${EXPECTED_RESULT}  ${14}

*** Test Cases ***
My Test 1
    ${numbers}=  Return Three Values
    ${result} =  Sum Of  @{numbers}
    Should Be Equal  ${result}  ${EXPECTED_RESULT}

My Test 2
    ${num1}  ${num2}  ${num3}=  Return Three Values
    ${result} =  Sum Of  ${num1}  ${num2}  ${num3}
    Should Be Equal  ${result}  ${EXPECTED_RESULT}
*** Keywords ***

Sum Of
    [Arguments]  ${a}  ${b}  ${c}
    ${sum}=  Evaluate  ${a} + ${b} + ${c}
    RETURN  ${sum}

Return Three Values
    RETURN    2    4    8