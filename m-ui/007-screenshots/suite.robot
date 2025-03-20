*** Settings ***
Documentation  ImageHorizonLibrary Test Suite Template
Resource       ./Resources/Keepass/Keepass.resource
Resource       ./Resources/Common/Common_keywords.resource
Suite Setup    Open Keepass
Suite Teardown    Close Keepass
Test Teardown  Test Finalization

*** Variables ***
${ROOT_DIR}       ${CURDIR}
${IMAGES_ROOT}    ${ROOT_DIR}/Resources/Keepass/images
${DATABASE}       ${ROOT_DIR}\\Resources\\Data\\robotmk-db.kdbx
${DATABASE_PW}    robotmk
${DB_ENTRY_NAME}     robotmk_test_entry_1
${ENTRY_EXP_PASS}     yV4d6taNbkDB5W8U2pI9

*** Test Cases ***

Verify Entry
    [Documentation]  Verifies that an entry exists in the database
    Open Database    ${DATABASE}    ${DATABASE_PW}
    Search Entry   ${DB_ENTRY_NAME}
    Verify Password   ${DB_ENTRY_NAME}    ${ENTRY_EXP_PASS}


*** Keywords ***

Test Finalization
    Run Keyword If Test Failed   Common_keywords.Take Screenshot