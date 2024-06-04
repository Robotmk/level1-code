*** Test Cases ***
My First Test
    A Static Keyword
    A Keyword with Arguments  Alice  12

*** Keywords ***
A Static Keyword
    Log    Hello, World

A Keyword with Arguments
    [Arguments]    ${person}    ${hour}
    Log    Hello ${person}, it's ${hour} o clock!