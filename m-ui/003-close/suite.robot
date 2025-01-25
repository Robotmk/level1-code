*** Settings ***
Documentation  ImageHorizonLibrary Test Suite Template
Resource  Resources/Keepass/Keepass.resource
Suite Setup    Open Keepass
Suite Teardown    Close Keepass

*** Variables ***
${ROOT_DIR}  ${CURDIR}
${IMAGES_ROOT}  ${ROOT_DIR}/Resources/Keepass/images

*** Test Cases ***

Test Placeholder
    # Wait some seconds to see the result
    Sleep  5
    No Operation