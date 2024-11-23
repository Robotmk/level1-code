*** Settings ***
Documentation    This suite demonstrates how to return values from a keyword
Resource  ${CURDIR}/res/My-Res.resource
Name      A Custom Suite Name

*** Test Cases ***
Log Paths
    [Documentation]    This test case logs different path variables from the suite and resource.
    Log Builtin Path Variables
    My-Res.Log The Resource Path Variables

Log Builtin Variables from Resource file
    [Documentation]    This test case logs different path variables form the Resource file.
    My-Res.Log The Resource Path Variables

Log Builtin Name Variables
    [Documentation]    This test case logs the names of the variables.
    Log To Console    The name of the Suite is in \${SUITE_NAME}: ${SUITE_NAME}.
    Log To Console    The name of the Test is in \${TEST_NAME}: ${TEST_NAME}.
    Log To Console    The Suite Documentation is in \${SUITE_DOCUMENTATION}: ${SUITE_DOCUMENTATION}.
    Log To Console    The Test Documentation is in \${TEST_DOCUMENTATION}: ${TEST_DOCUMENTATION}.

Log Prevous Test Information
    [Documentation]    This test case logs data about the last test. 
    Log To Console    The name of the last test is \${PREV_TEST_NAME}: ${PREV_TEST_NAME}.
    Log To Console    The status of the last test is \${PREV_TEST_STATUS}: ${PREV_TEST_STATUS}.

*** Keywords ***

Log Builtin Path Variables
    [Documentation]    This keyword logs different path variables.
    Log To Console    From the perspective of this file is \${CURDIR}: ${CURDIR}.
    Log To Console    Temporary files can be written into \${TEMPDIR}: ${TEMPDIR}.
    Log To Console    The Suite was started from \${EXECDIR}: ${EXECDIR}..
    Log To Console    The Suite file source is located at \${SUITE_SOURCE}: ${SUITE_SOURCE}.