*** Variables ***
&{CARS}  Volvo=XC90  BMW=X5  Audi=Q7

*** Test Cases ***
Tets one 
    Log  foo

Example If Statement
    VAR  ${value}  10
    IF    ${value} > 5
        Log    Value is greater than 5
    END



Test dict 
    &{surcharge0} =    Create Dictionary    name=surch0    id=0    provider=Test Company    cost=1200
    &{surcharge1} =    Create Dictionary    name=surch1    id=1    provider=Test Company    cost=1000
    @{surcharges} =    Create List    ${surcharge0}    ${surcharge1}
    No Operation