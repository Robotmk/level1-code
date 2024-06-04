*** Settings ***
Documentation  Execute this Robot on the command line with 
...            robot --variable CONTINENT:Europe

*** Variables ***
${CONTINENT}  Asia  # <--- Overwrite global CONTINENT variable for this test suite 

*** Test Cases ***
Logging A Global Variable
    Log To Console    Continent before Global Var kw: ${CONTINENT}
    Set Global Variable         ${CONTINENT}  America  # <--- changed from: Europe
    Log To Console    Continent after Global Var kw: ${CONTINENT}
