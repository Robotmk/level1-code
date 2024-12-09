*** Test Cases ***
My Test
    ${result} =  Sum Of  1  2
    Should Be Equal  ${result}  3
*** Keywords ***

Sum Of
    [Arguments]  ${a}  ${b}
    RETURN  ${a} + ${b}