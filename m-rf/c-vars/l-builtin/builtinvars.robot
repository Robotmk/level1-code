*** Settings ***
Documentation    This suite demonstrates how to return values from a keyword
Name      A Custom Suite Name

*** Test Cases ***
Log Paths
    Log    Suite name (\${SUITE_NAME}): ${SUITE_NAME}
    Log    Test name (\${TEST_NAME}): ${TEST_NAME}
    Log    Temporary files can be written into \${TEMPDIR}: ${TEMPDIR}
    Log    The Suite was started here (\${EXECDIR}): ${EXECDIR}
    Log    Location of this suite file (\${CURDIR}): ${CURDIR}
    Log    Full Suite file path (\${SUITE_SOURCE}): ${SUITE_SOURCE}