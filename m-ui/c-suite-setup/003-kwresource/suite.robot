*** Settings ***
Documentation  - Instead of "Wait For" and "Click Image" we will use 
...  "Wait For And Click" from the resource file, imported from the resource folder.
...  - Scripts & Image folder moved to resources
...  - Created "Puter" resource file to encapsulate the Puter related keywords

Library   ImageHorizonLibrary  
...    reference_folder=${IMAGES_ROOT}
...    confidence=0.95

# Import the IHL helper keywords
Resource  Resources/Common/IHL_keywords.resource
# Import the Puter related keywords
Resource  Resources/Puter/Puter.resource

Suite Setup    Open Puter
Suite Teardown    Close Puter

*** Variables ***
${ROOT_DIR}  ${CURDIR}
# Point to the new location of the images
${IMAGES_ROOT}  ${ROOT_DIR}/Resources/Puter/images

# ${BROWSER} variable moved to puter resource

*** Test Cases ***

Launch Puter
    # Wait max. 60s and click on the "Start menu" button
    Wait For And Click  applauncher  timeout=60
    # Open the "DevCenter"
    Wait For And Click  devcenter  timeout=10
    Wait for  myapps  timeout=20
    Sleep  4

# *** Keywords ***
# Start/Close Puter keywords moved to Puter resource