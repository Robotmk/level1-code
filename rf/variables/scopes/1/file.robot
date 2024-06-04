*** Settings ***
Documentation  Execute this Robot on the command line with 
...            robot --variable CONTINENT:Europe

*** Test Cases ***
Logging A Global Variable
    Should Be Equal As Strings    ${CONTINENT}    Europe
    Log To Console    ${CONTINENT}
