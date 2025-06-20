*** Settings ***
Documentation  This suite demonstrates how to use indentation and separation in syntax.

*** Test Cases ***

Example Test Case
    [Documentation]  This is an example test case demonstrating indentation and separation
    My Log Keyword  Lorem Ipsum

*** Keywords ***

My Log Keyword
    [Arguments]  ${message}
    Log  ${message}