*** Comments ***
Objective: second test "Invalid Login"

Key Learnings:
- Make keywords reusable
- Store keywords in resource files
- use RF control structures

Why should you test a login with INVALID credentials... ? 
- Think of a misconfigured/buggy webshop which accepts ANY password... 

A Login test with invalid credentials behaves different from a valid login in one thing: 
We expect an error message. 
We could write another keyword "Invalid Login" (see at the end of this file), but 
this would lead to a lot of redundant code. 

Instead, we add a flag argument to the Login keyword which controls how the keyword 
should assert the success. With a wrong password, "success" means an error message. 

*** Settings ***
Documentation       This suite contains tests to verify that login
...                 and basic basket/ordering functionality is working.

Resource            webshop_oxid.resource
Library             Browser
Library             CryptoLibrary    password=%{ROBOT_CRYPTO_KEY_PASSWORD_OXID}
...                     variable_decryption=True    key_path=${CURDIR}${/}keys   

*** Variables ***
${BROWSER}      chromium


*** Test Cases ***
Login with valid credentials
    [Documentation]    The purpose of this test case is to verify that a user can successfully log
    ...    in to the application using valid credentials.

    New Browser    browser=${BROWSER}    headless=False
    New Context    viewport=${None}    locale=de-DE
    New Page    ${URL}
    Get text  ${HOME_BARGAIN_HEADLINE}  *=  Angebote der Woche
    Login    ${USERNAME}    ${PASSWORD}   

Login with invalid credentials
    [Documentation]    The purpose of this test case is to verify that a user with invalid credentials
    ...    cannot log into the shop system.
    New Browser    browser=${BROWSER}    headless=False
    New Context    viewport=${None}    locale=de-DE
    New Page    ${URL}
    Get text  ${HOME_BARGAIN_HEADLINE}  *=  Angebote der Woche
    Login    ${USERNAME}    thisisanincorrectpassword!    expectfail=True

Search Item And Add To Basket
    [Documentation]    The purpose of this test case is to verify that a user can search for an item,
    ...    add it into the basket and get an expected total price.
    No Operation


