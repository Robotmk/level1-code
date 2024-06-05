*** Test Cases ***

Test One
    VAR  ${CAR}  Ford  scope=test
    VAR  ${COLOR}  blue  scope=test
    Choose Car

*** Keywords ***
Choose Car
    VAR  ${CAR}  Volvo
    Log  Choosing now a ${COLOR} ${CAR}
    