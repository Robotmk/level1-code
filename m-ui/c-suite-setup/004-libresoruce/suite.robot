*** Settings ***
Documentation  - Removed the IHL import from the suite file, moved it 
...  into a separate "library importer" resource file
...  - IHL_Keywords.resource imports the IHL from a resource file
...  - Created Puter keywords

Resource  Resources/Common/IHL_keywords.resource
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

