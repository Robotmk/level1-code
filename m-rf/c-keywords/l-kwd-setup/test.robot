*** Settings ***
Documentation  Demonstrate the usage of Keyword setup/Teardown.

*** Variables ***
${SETUP}       Keyword Initialization
${TEARDOWN}    Keyword Finalization

*** Test Cases ***
Test Case 1
    My Keyword

Test Case 2
    My Keyword Using variables

*** Keywords ***
My Keyword
    [Setup]       Keyword Initialization
    Log   Doing something... 
    [Teardown]    Keyword Finalization

My Keyword Using variables
    [Setup]       ${SETUP}
    Log   Doing something... 
    [Teardown]    ${TEARDOWN}

Keyword Initialization
    Log  Preparing...
    Log  ...the keyword environment.

Keyword Finalization
    Log  Finalizing...
    Log  ...and cleaning up 🧹