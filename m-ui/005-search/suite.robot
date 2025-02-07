*** Settings ***
Documentation  ImageHorizonLibrary Test Suite Template
Resource       Resources/Keepass/Keepass.resource
Suite Setup    Open Keepass
Suite Teardown    Close Keepass

*** Variables ***
${ROOT_DIR}       ${CURDIR}
${IMAGES_ROOT}    ${ROOT_DIR}/Resources/Keepass/images
${DATABASE}       ${ROOT_DIR}\\Resources\\Data\\robotmk-db.kdbx
${DATABASE_PW}    robotmk
# Name of the entry to search for
${DB_ENTRY_NAME}     test entry
# Image of the extected search result
${ENTRY_IMG}     robotmk_test_entry

*** Test Cases ***

Verify Entry
    [Documentation]  Verifies that an entry exists in the database
    Open Database    ${DATABASE}    ${DATABASE_PW}
    # new keyword to search for an entry and expect the result image. 
    Search Entry   ${DB_ENTRY_NAME}    ${ENTRY_IMG}