*** Settings ***
Documentation    This suite demonstrates how to return values from a keyword
Library    OperatingSystem

*** Variables ***
${SENTENCE}    Sapien risus aliquet torquent, vivamus feugiat curae est.
${EXPECTED_LENGTH}    57

*** Test Cases ***
Returning A Scalar
    # length of ${SENTENCE} should be 57 (line 7)
    ${length} =    Get Length    ${SENTENCE}
    Should Be Equal As Integers   ${length}    ${EXPECTED_LENGTH}

Returning A List
    # There should be a file called returnvalue.robot 
    @{files} =  List Directory    ${CURDIR}
    Should Contain    ${files}   returnvalue.robot

Returning a Dict Example
    # Log the PATH environment variable
    &{vars}=    Get Environment Variables
    Log    PATH is: ${vars}[PATH]

Multiple Return Example
    # Split the path server/logs/server.log into folder and file
    # Path must be server/logs and file server.log
    ${path}    ${file} =    Split Path    server/logs/server.log
    Should Be Equal    ${path}    server/logs
    Should Be Equal    ${file}    server.log