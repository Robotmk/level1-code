*** Settings ***
Documentation  - Created Puter keyword "Open Devcenter" in the Puter resource
...    - Removed the IHL import from the Puter resource file, and moved it
...      into a separate "library importer" resource file
...    - IHL_Keywords.resource imports the IHL from a resource file

Resource  Resources/Puter/Puter.resource

Suite Setup    Open Puter
Suite Teardown    Close Puter

*** Variables ***
${ROOT_DIR}  ${CURDIR}
${IMAGES_ROOT}  ${ROOT_DIR}/Resources/Puter/images

*** Test Cases ***

Launch Puter
    Puter.Open Devcenter
    Sleep  4

