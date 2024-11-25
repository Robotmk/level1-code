*** Test Cases ***
Alarm Clock Test
    Static Alarm Clock

Positional Alarm Clock Tests
    Alarm Clock With Positional Args    Bob    6    get up
    Alarm Clock With Positional Args    Bob    6    get up
    Alarm Clock With Positional Args    Bob    6    get up

*** Keywords ***
Static Alarm Clock
    Log    Good morning Bob, it's 6 o clock! Time to get up!

Alarm Clock With Positional Args
    [Arguments]    ${person}    ${hour}  ${action}
    Log    Good morning ${person}, it's ${hour} o clock! Time to ${action}!

Alarm Clock With Positional Args and Default Values
    [Arguments]    ${person}=Bob    ${hour}=11
    Log    Hello ${person}, it's ${hour} o clock!