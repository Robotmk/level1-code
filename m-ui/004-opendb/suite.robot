*** Settings ***
Documentation  ImageHorizonLibrary Test Suite Template
Resource       Resources/Keepass/Keepass.resource
Suite Setup    Open Keepass
Suite Teardown    Close Keepass

*** Variables ***
${ROOT_DIR}       ${CURDIR}
${IMAGES_ROOT}    ${ROOT_DIR}/Resources/Keepass/images
# Absolute path to the database file. 
# Because this path is entered into the keepass UI, 
# it must contain backslashes, which are escaped. 
${DATABASE}       ${ROOT_DIR}\\Resources\\Data\\robotmk-db.kdbx
# Password for the database file
${DATABASE_PW}    robotmk

*** Test Cases ***

Verify Entry
    [Documentation]  Verifies that an entry exists in the database
    # Passing the database and password variables to the keyword
    Open Database    ${DATABASE}    ${DATABASE_PW}