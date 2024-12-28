*** Variables ***
&{CARS}
...    Volvo=XC90
...    BMW=X5
...    Audi=Q7

*** Test Cases ***
Without Embedded Arguments
    ${volvo}=  Get A Car  Volvo  blue
    ${bmw}=  Get A Car  BMW   black
    ${audi}=  Get A Car   Audi  white

With Embedded Arguments
    ${volvo}=  Get A blue Volvo
    ${bmw}=  Get A black BMW
    ${audi}=  Get A white Audi


*** Keywords ***

Get A Car
    [Arguments]  ${car}  ${color}
    # ... do something with ${car} and ${color} ...
    RETURN  ${CARS}[${car}]  ${color}

Get A ${color} ${car}
    # ... do something with ${car} and ${color} ...
    RETURN  ${CARS}[${car}]  ${color}