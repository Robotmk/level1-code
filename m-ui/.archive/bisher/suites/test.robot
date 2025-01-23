*** Settings ***
Resource  ../resources/ImageHorizonKeywords.resource


*** Variables ***
${ROOT_DIR}  ${CURDIR}

*** Test Cases ***

Test One
    Wait For And Click    start
    Sleep  4
    Wait For And Click    devcent
    No Operation  
      


*** Keywords ***

