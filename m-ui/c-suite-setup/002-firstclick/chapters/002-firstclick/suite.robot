*** Settings ***
Documentation  The IHL is imported with arguments. 
...    - The keywords to open and close Puter were moved to Suite Setup/Teardown. 
...    - Variables are set
...    - `Wait For` and `Click Image` are used to interact with the Puter application
Library  Process

# Library import with arguments:
Library   ImageHorizonLibrary  
...    reference_folder=${IMAGES_ROOT}
...    confidence=0.95

Suite Setup    Open Puter
Suite Teardown    Close Puter

*** Variables ***
${BROWSER}      chrome
# a useful variable to alwasy refer to the root of the project
${ROOT_DIR}  ${CURDIR}
# This variable is used to store the path to the images folder (needles)
${IMAGES_ROOT}  ${ROOT_DIR}/images

*** Test Cases ***

Launch Puter
    # Cumbersome: This is how the library suggests to be used. We will fix this. 
    # Click on the "Start menu" button
    Wait For  applauncher  timeout=60
    Click Image  applauncher
    # Open the "DevCenter"
    Wait For  devcenter  timeout=10
    Click Image  devcenter
    # Wait for the devcenter to open
    Wait for  myapps  timeout=20
    Sleep  4

*** Keywords ***

Open Puter
    Run Process  powershell.exe  ${CURDIR}/Scripts/open_puter.ps1  -Browser  ${BROWSER}

Close Puter
    Run Process   taskkill /F /IM ${BROWSER}.exe   shell=True
