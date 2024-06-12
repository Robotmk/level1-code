*** Test Cases ***
A Static Test
    Store Data   simon_meggle

A Test With A Env Variable
    Store Data   %{USER}

A Test With A Env Variable And A Default Value
    Store Data   %{USER=simon_meggle}

*** Keywords ***
Store Data
    [Arguments]    ${data}
    Log    ${data}