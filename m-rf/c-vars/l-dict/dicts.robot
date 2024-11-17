*** Variables ***
&{USER_DATA}         name=robotmk    password=secret
&{MORE_USER_DATA}    role=admin  &{USER_DATA}  status=active

*** Test Cases ***
A Static Test
    Log Many    name=robotmk    password=secret

A Test With A Dict Variable
    Log Many    &{USER_DATA}

A Test With An Extended Dict
    Log Many    &{MORE_USER_DATA}