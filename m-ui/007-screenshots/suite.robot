*** Settings ***
Documentation  ImageHorizonLibrary Test Suite Template
Resource       ./Resources/Keepass/Keepass.resource
# import the Screenshot keyword
Resource       ./Resources/Common/Common_keywords.resource
Suite Setup    Open Keepass
Suite Teardown    Close Keepass
# Add test Teardown
Test Teardown  Test Finalization

*** Variables ***
${ROOT_DIR}       ${CURDIR}
${IMAGES_ROOT}    ${ROOT_DIR}/Resources/Keepass/images
${DATABASE}       ${ROOT_DIR}\\Resources\\Data\\robotmk-db.kdbx
${DATABASE_PW}    robotmk
${DB_ENTRY_NAME}     test entry
${ENTRY_IMG}     robotmk_test_entry
# The password expected to be in the test entry
${ENTRY_EXP_PASS}     yV4d6taNbkDB5W8U2pI9

*** Test Cases ***

Verify Entry
    [Documentation]  Verifies that an entry exists in the database
    Open Database    ${DATABASE}    ${DATABASE_PW}
    Search Entry   ${DB_ENTRY_NAME}    ${ENTRY_IMG}
    # New keyword which reads the password from an entry and compares it 
    # against the expected value
    Verify Password   ${ENTRY_IMG}    ${ENTRY_EXP_PASS}

*** Keywords ***

# Only take a screenshot if the 
Test Finalization
    Run Keyword If Test Failed   Common_keywords.Take Screenshot