*** Settings ***
Documentation     A simple introduction to the anatomy of a Robot Framework test suite.
Library           BuiltIn

*** Variables ***
${Number1}    10
${Number2}    20

*** Test Cases ***
Add Numbers
    [Documentation]    A simple test case that adds two numbers.
    ${Sum}=    Add Two Numbers    ${Number1}    ${Number2}
    Should Be Equal As Integers    ${Sum}    30

Subtract Numbers
    [Documentation]    A simple test case that subtracts one number from another.
    ${Difference}=    Subtract Two Numbers    ${Number2}    ${Number1}
    Should Be Equal As Integers    ${Difference}    10

*** Keywords ***
Add Two Numbers
    [Documentation]    A keyword that adds two numbers and returns the result.
    [Arguments]    ${num1}    ${num2}
    ${result}=    Evaluate    ${num1} + ${num2}
    RETURN    ${result}

Subtract Two Numbers
    [Documentation]    A keyword that subtracts one number from another and returns the result.
    [Arguments]    ${num1}    ${num2}
    ${result}=    Evaluate    ${num1} - ${num2}
    RETURN    ${result}