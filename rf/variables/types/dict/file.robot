*** Test Cases ***
A Static Test
    Login    name=robotmk    password=secret

A Test With A Dict Variable
    Login    &{USER}

Extending A Dict Dynamically    
    Login   &{USER}  role=admin