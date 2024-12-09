*** Settings ***
Documentation  Demonstrate the usage of the RETURN statement.

*** Variables ***
${EXPECTED_RESULT}  14

*** Test Cases ***
My Test
    No Operation
    # Get the values from "Return Three Values"
    # Calculate the sum of the values with "Sum Of"
    # Use "Should Be Equal" to compare the result with the expected value

*** Keywords ***

Sum Of
    [Arguments]  ${a}  ${b}  ${c}
    ${sum}=  Evaluate  ${a} + ${b} + ${c}
    # Return the result

Return Three Values
    No Operation