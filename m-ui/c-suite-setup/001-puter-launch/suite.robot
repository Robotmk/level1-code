*** Settings ***
Documentation  Launch the given browser, open the Puter App and close the browser
Library  Process

*** Variables ***
${BROWSER}  chrome

*** Test Cases ***

Launch Puter
    Open Puter
    Sleep  10
    Close Puter


*** Keywords ***

Open Puter
    Run Process  powershell.exe  ${CURDIR}/Scripts/open_puter.ps1  -Browser  ${BROWSER}

Close Puter
    Run Process   taskkill /F /IM ${BROWSER}.exe   shell=True
