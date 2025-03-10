*** Settings ***
Documentation    This suite demonstrates the use of suite and test variables.

*** Variables ***
${CAR}      Lexus
${COLOR}    black  

*** Test Cases ***
Test First Car
    VAR  ${CAR}  VW  scope=test
    Log  Choosing a ${COLOR} ${CAR}
    VAR  ${COLOR}  yellow  scope=suite

Test Second Car
    Log  Choosing now a ${COLOR} ${CAR}!