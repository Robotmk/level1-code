*** Comments ***
Objective: Create the tests skeleton. 

Key Learnings: 
- Comments
- TSSD (Test Suite Specification Document)
- No Operation keyword



*** Settings ***
Documentation   This suite contains tests to verify that login 
...    and basic basket/ordering functionality is working.    <--HERE--  Taken from the TSSD's "Suite Objective"

*** Test Cases ***
Login with valid credentials
    [Documentation]    The purpose of this test case is to verify that a user can successfully log 
    ...    in to the application using valid credentials. <--HERE--  Taken from the TSSD's "Test Objective"
    No Operation  #  <--HERE--   Use "No Operation" as a placeholder, it does nothing. (like "pass" in Python)

Login with invalid credentials
    [Documentation]    The purpose of this test case is to verify that a user with invalid credentials 
    ...    cannot log into the shop system.  <--HERE--  Taken from the TSSD's "Test Objective"
    No Operation

Search Item And Add To Basket
    [Documentation]    The purpose of this test case is to verify that a user can search for an item, 
    ...    add it into the basket and get an expected total price.  <--HERE--  Taken from the TSSD's "Test Objective"
    No Operation