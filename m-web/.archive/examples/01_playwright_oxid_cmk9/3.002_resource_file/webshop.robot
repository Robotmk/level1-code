*** Comments ***
Objective: Variables from resource file

Key Learnings: 
- create a resource file
- import a resource file

!! ACTION: Run the test with the debugger and see if the variables are loaded correctly


*** Settings ***
Documentation   This suite contains tests to verify that login 
...    and basic basket/ordering functionality is working.   

Resource  webshop_oxid.resource

*** Test Cases ***
Login with valid credentials
    [Documentation]    The purpose of this test case is to verify that a user can successfully log 
    ...    in to the application using valid credentials. 
    No Operation  

Login with invalid credentials
    [Documentation]    The purpose of this test case is to verify that a user with invalid credentials 
    ...    cannot log into the shop system. 
    No Operation

Search Item And Add To Basket
    [Documentation]    The purpose of this test case is to verify that a user can search for an item, 
    ...    add it into the basket and get an expected total price. 
    No Operation