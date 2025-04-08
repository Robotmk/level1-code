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
    Log  Cars: ${volvo}, ${bmw}, ${audi}

With Embedded Arguments
    ${volvo}=  Get A "blue Volvo" car
    ${bmw}=  Get A "black BMW" car
    ${audi}=  Get A "white Audi" car
    Log  Cars: ${volvo}, ${bmw}, ${audi}


*** Keywords ***

Get A Car
    [Arguments]  ${car}  ${color}
    RETURN  A ${color} ${CARS}[${car}]

Get A "${color} ${car}" car
    RETURN  A ${color} ${CARS}[${car}]