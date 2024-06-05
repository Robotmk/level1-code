*** Settings *** 
Documentation  Execute this Robot on the command line with 
...            robot --variable CAR:Volvo

*** Variables ***
${CAR}      Ford
${COLOR}    blue  

*** Test Cases ***
Test Car
    VAR  ${CAR}  ALFA ROMEO  
    Log  Choosing a ${COLOR} ${CAR}!