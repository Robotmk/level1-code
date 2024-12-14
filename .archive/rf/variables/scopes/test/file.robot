*** Test Cases ***

Test One
    VAR  ${CAR}  Ford  scope=test
    VAR  ${COLOR}  blue  scope=test
    Choose First Car
    Choose Second Car

*** Keywords ***
Choose First Car
    VAR  ${CAR}  Volvo
    Log  Choosing a ${COLOR} ${CAR}
    VAR  ${COLOR}  red  scope=test

Choose Second Car
    Log  Choosing now a ${COLOR} ${CAR}!
