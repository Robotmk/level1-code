*** Settings ***
Documentation  ImageHorizonLibrary Test Suite Template
Resource  Resources/Keepass/Keepass.resource
Suite Setup    Open Keepass
Suite Teardown    Close Keepass

*** Variables ***
${ROOT_DIR}  ${CURDIR}
${IMAGES_ROOT}  ${ROOT_DIR}/Resources/Application/images

*** Test Cases ***

Test Placeholder
    No Operation