*** Settings ***
Library  String
Resource  ./lorem-ipsum.resource

*** Test Cases ***
Test One
    ${second_line}=  Get Line  ${MYSTRING}  1
    Log To Console  The second line is: ${second_line}