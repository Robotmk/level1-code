*** Variables ***
${CAR}      Ford
${COLOR}    blue  

*** Test Cases ***
Test First Car
    VAR  ${CAR}  Volvo
    Log  Choosing a ${COLOR} ${CAR}
    VAR  ${COLOR}  red  scope=suite

Test Second Car
    Log  Choosing now a ${COLOR} ${CAR}!