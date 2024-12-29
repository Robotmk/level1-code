*** Settings ***
Documentation     A suite which demonstrates data-driven testing, 
...  with a global test template and one test for each data set. 
Test Template     Calculate Sum

*** Test Cases ***              
Test One  1  1
Test Two  1  2
Test Three  2  3
Test Four  3  4
Test Five  5  5

*** Keywords ***
Calculate Sum
    [Arguments]    ${no1}    ${no2} 
    ${total}=      Evaluate    ${no1} + ${no2}
    RETURN    ${total}