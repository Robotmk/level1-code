*** Settings ***
Library  Process


*** Keywords ***


Open Puter
    Run Process  powershell.exe  ${CURDIR}/../scripts/open_puter.ps1  -Browser  ${BROWSER}

Close Puter
    Run Process   taskkill /F /IM ${BROWSER}.exe   shell=True
