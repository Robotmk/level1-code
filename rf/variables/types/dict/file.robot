*** Test Cases ***
A Static Test
    Log To Console    name=robotmk    password=secret

A Test With A Dict Variable
    Log To Console    &{USER}

Extending A Dict Dynamically    
    Log To Console    &{USER}  role=admin