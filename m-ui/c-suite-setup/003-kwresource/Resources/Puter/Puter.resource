*** Settings ***
Library  Process

*** Variables ***
${BROWSER}      chrome

*** Keywords ***
Open Puter
    Run Process  powershell.exe  ${ROOT_DIR}/Resources/Puter/Scripts/open_puter.ps1  -Browser  ${BROWSER}

Close Puter
    Run Process   taskkill /F /IM ${BROWSER}.exe   shell=True
