*** Settings ***
Documentation    This suite demonstrates how to return values from a keyword
Resource  ${CURDIR}/res/My-Res.resource
Name      A Custom Suite Name

*** Test Cases ***
Log Paths
    [Documentation]    This test case logs different path variables from the suite and resource.
    Log Builtin Path Variables
    My-Res.Log The Resource Path Variables

Log Builtin Name Variables
    [Documentation]    This test case logs the names of the variables.
    Log    The name of the Suite is in {SUITE_NAME}: ${SUITE_NAME}
    Log    The name of the Test is in {TEST_NAME}: ${TEST_NAME}
    Log    The Suite Documentation is in {SUITE_DOCUMENTATION}: ${SUITE_DOCUMENTATION}
    Log    The Test Documentation is in {TEST_DOCUMENTATION}: ${TEST_DOCUMENTATION}

Log Prevous Test Information
    [Documentation]    This test case logs data about the last test. 
    Log    The name of the last test is {PREV_TEST_NAME}: ${PREV_TEST_NAME}
    Log    The status of the last test is {PREV_TEST_STATUS}: ${PREV_TEST_STATUS}

*** Keywords ***

Log Builtin Path Variables
    [Documentation]    This keyword logs different path variables.
    Log    From the perspective of this file is {CURDIR}: ${CURDIR}
    Log    Temporary files can be written into {TEMPDIR}: ${TEMPDIR}
    Log    The Suite was started from {EXECDIR}: ${EXECDIR}
    Log    The Suite file source is located at {SUITE_SOURCE}: ${SUITE_SOURCE}