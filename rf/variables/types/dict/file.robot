*** Variables ***
&{USER}    name=robotmk    password=secret

${VARFOO}   bla

*** Test Cases ***
A Static Test
    Log Many    name=robotmk    password=secret

A Test With A Dict Variable
    Log Many    &{USER}

Extending A Dict Dynamically    
    Log Many    &{USER}  role=admin


sfggd
    Log Many    ${VARFOO}