*** Settings ***
Documentation    This suite demonstrates how to return values from a keyword
Library    OperatingSystem

*** Test Cases ***
Returning A Scalar
    ${length} =    Get Length    Sapien risus aliquet torquent, vivamus feugiat curae est.
    Should Be Equal    ${length}    57

Returning A List
    ${files} =  List Directory    ${CURDIR}
    Should Contain    ${files}   returnvalue.robot

Returning a Dict Example
    ${vars}=    Get Environment Variables
    Log    PATH is: ${vars}[PATH]

Multiple Return Example
    ${path}    ${file} =    Split Path    server/logs/server.log
    Should Be Equal    ${path}    server/logs
    Should Be Equal    ${file}    server.log