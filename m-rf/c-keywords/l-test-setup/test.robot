*** Settings ***
Documentation  Demonstrate the usage Test setup.
Test Setup    Prepare Environment

*** Test Cases ***
Test Case 1
    Log    Running Test Case 1

Test Case 2
    Log    Running Test Case 2

Test Case 3
    [Setup]  NONE
    Log    Running Test Case 3 (without setup)

*** Keywords ***
Prepare Environment
    [Documentation]    Set up the necessary environment before each test.
    Log    Setting up the environment...