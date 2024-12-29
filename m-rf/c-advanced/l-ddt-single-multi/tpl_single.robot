*** Settings ***
Documentation     A suite which demonstrates data-driven testing, 
...  with a test scoped template and a SINGLE test for all data sets. 
Test Template     Calculate Sum

*** Test Cases ***              
Calculate Sums  
    [Template]  Calculate Sum
    1  1
    1  2
    2  3
    3  4
    5  5

*** Keywords ***
Calculate Sum
    [Arguments]    ${no1}    ${no2} 
    ${total}=      Evaluate    ${no1} + ${no2}
    RETURN    ${total}