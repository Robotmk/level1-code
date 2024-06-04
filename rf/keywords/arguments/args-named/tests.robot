*** Test Cases ***
My First Test
    A Keyword with Default Arguments  Alice  12
    A Keyword with Default Arguments  Alice
    A Keyword with Default Arguments  12
    A Keyword with Default Arguments  hour=12
    A Keyword with Default Arguments  person=Bob  hour=9

*** Keywords ***

A Keyword with Default Arguments
    [Arguments]    ${person}=Tim    ${hour}=10
    Log To Console    Hello ${person}, it's ${hour} o clock!
