*** Settings *** 
Documentation  This suite demonstrates the use of global variables.
...    Execute this Robot on the command line with 
...            robot --variable CAR:Volvo

*** Variables ***
${CAR}      Ford
${COLOR}    blue  

*** Test Cases ***

Choose First Car
    VAR  ${CAR}    ALFA ROMEO
    VAR  ${COLOR}  black  scope=suite
    Log  Choosing a ${COLOR} ${CAR}!

Choose Second Car
    Log  Choosing now a ${COLOR} ${CAR}!