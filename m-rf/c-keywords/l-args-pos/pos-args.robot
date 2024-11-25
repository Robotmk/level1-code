*** Settings ***
Library  String
Resource  ./lorem-ipsum.resource

*** Test Cases ***
Test One
    ${second_line}=  Get Line  ${MYSTRING}  1
    Log To Console  The second line is: ${second_line}

*** Keywords ***
Get Line As User Keyword
    [Arguments]  ${string}  ${line_number}   # <--- 
    ${lines}=  Split String  ${string}  \n
    ${line}=  Get From List  ${lines}  ${line_number}
    RETURN  ${line}