*** Settings ***
Documentation    This suite demonstrates how to return values from a keyword
Library    OperatingSystem

*** Variables ***
${SENTENCE}    Sapien risus aliquet torquent, vivamus feugiat curae est.
${EXPECTED_LENGTH}    57

*** Test Cases ***
Scalar From Keyword
    # length of ${SENTENCE} should be 57 (line 7)
    ${length} =    Get Length    ${SENTENCE}
    Should Be Equal As Integers   ${length}    ${EXPECTED_LENGTH}

List From Keyword
    # There should be a file called returnvalue.robot 
    @{files} =  List Directory    ${CURDIR}
    Should Contain    ${files}   returnvalue.robot

List From Keyword 2
    # Split the path server/logs/server.log into folder and file
    # Path must be server/logs and file server.log
    ${path}    ${file} =    Split Path    server/logs/server.log
    Should Be Equal    ${path}    server/logs
    Should Be Equal    ${file}    server.log

Dict From Keyword
    # Log the PATH environment variable
    &{vars}=    Get Environment Variables
    Log    PATH is: ${vars}[PATH]
