*** Test Cases ***
My First Test
    A Static Keyword
    A Keyword with Positional Arguments  Alice  12
    A Keyword with Positional Arguments And Default Values
    # Try this
    # A Keyword with Positional Arguments And Default Values  8

*** Keywords ***
A Static Keyword
    Log    Hello, World

A Keyword with Positional Arguments
    [Arguments]    ${person}    ${hour}
    Log    Hello ${person}, it's ${hour} o clock!

A Keyword with Positional Arguments And Default Values
    [Arguments]    ${person}=Bob    ${hour}=11
    Log    Hello ${person}, it's ${hour} o clock!