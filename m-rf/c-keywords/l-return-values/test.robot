*** Settings ***
Documentation  The aim of this test is to calculate the sum of three numbers 
...  and compare them with an expected result.

*** Variables ***
${EXPECTED_RESULT}  14

*** Test Cases ***
My Test
    No Operation
    # -> Complete the "Return Three Values" keyword
    # -> Call "Return Three Values" and store them.
    # -> Calculate the sum of the values with "Sum Of" and store the result.
    # -> Compare the result with "Should Be Equal As Integers"
    #    (https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Should%20Be%20Equal%20As%20Integers) 

*** Keywords ***

Sum Of
    [Arguments]  ${a}  ${b}  ${c}
    ${sum}=  Evaluate  ${a} + ${b} + ${c}
    # -> Return the result

Return Three Values
    # -> Return 3 values which sum up to ${EXPECTED_RESULT}
    No Operation