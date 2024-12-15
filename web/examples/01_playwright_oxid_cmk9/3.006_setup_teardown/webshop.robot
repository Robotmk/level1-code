*** Comments ***
Objective: use setup/teardown methods

Key Learnings:
- Setup/Teardown in Suite and Tests

Both Tests (valid/invalid Login) contain redundant keywords just to open the web shop's landing page.
Even worse, "New Browser" wastes time/resources because it is enough to create a new _context_ for each test
(which includes a new page).

As this is not a relevant part of the test (indeed, it's a precondition), we can move these keywords out
into Robot Framework hooks for setup/teardown.

#  !!ACTION: Execute the suite - it should work as before, but with much less boilerplate code in the tests.

*** Settings ***
Documentation       This suite contains tests to verify that login
...                 and basic basket/ordering functionality is working.

Resource            webshop_oxid.resource
Library             Browser
Library             CryptoLibrary    password=%{ROBOT_CRYPTO_KEY_PASSWORD_OXID}
...                     variable_decryption=True    key_path=${CURDIR}${/}keys   

Test Setup          Open Webshop    #    <--HERE--    This user keyword is called just before each test


*** Variables ***
${BROWSER}      chromium


*** Test Cases ***
Login with valid credentials
    [Documentation]    The purpose of this test case is to verify that a user can successfully log
    ...    in to the application using valid credentials.
    #    <--HERE--    Removed New Browser/Context/Page
    Login    ${USERNAME}    ${PASSWORD}   

Login with invalid credentials
    [Documentation]    The purpose of this test case is to verify that a user with invalid credentials
    ...    cannot log into the shop system.
    #    <--HERE--    Removed New Browser/Context/Page
    Login    ${USERNAME}    thisisanincorrectpassword!    expectfail=True

Search Item And Add To Basket
    [Documentation]    The purpose of this test case is to verify that a user can search for an item,
    ...    add it into the basket and get an expected total price.
    No Operation


