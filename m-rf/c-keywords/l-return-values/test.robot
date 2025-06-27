*** Settings ***
Documentation  Demonstrate the usage of the RETURN statement.

# The aim of this test is to calculate the sum of three numbers 
# and compare them with an expected result.

*** Variables ***
${EXPECTED_RESULT}  14

*** Test Cases ***
My Test
    No Operation
    # -> Get the values from "Return Three Values"
    # -> Calculate the sum of the values with "Sum Of"
    # -> Use "Should Be Equal As Integers"
    #    (https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Should%20Be%20Equal%20As%20Integers) 
    #    to compare the result with ${EXPECTED_RESULT}

*** Keywords ***

Sum Of
    [Arguments]  ${a}  ${b}  ${c}
    ${sum}=  Evaluate  ${a} + ${b} + ${c}
    # -> Return the result

Return Three Values
    # -> Return some values
    No Operation