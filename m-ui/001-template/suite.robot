*** Settings ***
Documentation  ImageHorizonLibrary Test Suite Template
Resource  Resources/Application/Application.resource
Suite Setup    Open Application
Suite Teardown    Close Application

*** Variables ***
${ROOT_DIR}  ${CURDIR}
${IMAGES_ROOT}  ${ROOT_DIR}/Resources/Application/images

*** Test Cases ***

Test Placeholder
    No Operation