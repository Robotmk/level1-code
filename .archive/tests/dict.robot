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