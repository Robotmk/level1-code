*** Settings ***
Library  Process
Resource  ../Common/IHL_keywords.resource

*** Variables ***
${BROWSER}      chrome

*** Keywords ***
Open Puter
    Run Process  powershell.exe  ${ROOT_DIR}/Resources/Puter/Scripts/open_puter.ps1  -Browser  ${BROWSER}

Close Puter
    Run Process   taskkill /F /IM ${BROWSER}.exe   shell=True

# Created the first two Application keywords
Open Devcenter
    [Documentation]  Opens the Devcenter in Launch menu
    Open App Launcher
    Wait for  myapps  timeout=20    

Open App Launcher
    [Documentation]  Opens the App Launcher
    Wait For And Click  applauncher  timeout=60