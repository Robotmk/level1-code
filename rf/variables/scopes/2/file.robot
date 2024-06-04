*** Settings ***
Documentation  Execute this Robot on the command line with 
...            robot --variable CONTINENT:Europe

*** Test Cases ***
Logging A Global Variable
    # The Keyword `Set Global Variable` can overwrite global vars during runtime. 
    Set Global Variable         ${CONTINENT}  America  # <--- changed from: Europe
    Should Be Equal As Strings  ${CONTINENT}    America
    Log To Console    Continent is: ${CONTINENT}
