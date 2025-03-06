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
${DB_ENTRY_NAME}     test entry
${ENTRY_IMG}     robotmk_test_entry
${ENTRY_EXP_PASS}     yV4d6taNbkDB5W8U2pI9

*** Test Cases ***

Verify Entry
    [Documentation]  Verifies that an entry exists in the database
    # Start the video recording
    Start Video Recording  fps=10  embed=True  embed_width=1200px
    Open Database    ${DATABASE}    ${DATABASE_PW}
    Search Entry   ${DB_ENTRY_NAME}    ${ENTRY_IMG}
    Verify Password   ${ENTRY_IMG}    ${ENTRY_EXP_PASS}
    # Stop the recording (if no failure happened before)
    Stop Video Recording  save_to_disk=False

*** Keywords ***

Test Finalization
    Run Keyword If Test Failed   Common_keywords.Take Screenshot