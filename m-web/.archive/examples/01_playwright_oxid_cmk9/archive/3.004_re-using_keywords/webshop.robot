*** Comments ***
-> Create second login test (invalid credentials) 


Key Learning: 
- Make keywords reusable
- use RF control structures

Why should you test a login with INVALID credentials... ? 
- Think of a misconfigured/buggy webshop which accepts ANY password... 

A Login test with invalid credentials behaves different from a valid login in one thing: 
We expect an error message. 
We could write another keyword "Invalid Login" (see at the end of this file), but 
this would lead to a lot of redundant code. 

Instead, we add a flag argument to the Login keyword which controls how the keyword 
should assert the success. With a wrong password, "success" means an error message. 

!! ACTION: See the bad code example below and understand why this code smells. 

*** Settings ***
Documentation       Oxid eshop test for login and item search. 
Library             Browser  enable_presenter_mode={"duration": "1 seconds", "width": "6px", "style": "dotted", "color": "red"}
Library             CryptoLibrary    password=%{ROBOT_CRYPTO_KEY_PASSWORD_OXID}
...                     variable_decryption=True    key_path=${CURDIR}${/}keys   


*** Variables ***
${URL}          https://oxid.robotmk.org
${BROWSER}      chromium
${USERNAME}     mail@robotmk.org   
${PASSWORD}     crypt:bD22YdO6Om/M63SHz3clvZ4UKpEonuvUh0nO+vHymmFGWjzPveg+dSTFGlVRmSk7ZQQj7anvpBA=    #


*** Test Cases ***
Login with valid credentials
    [Documentation]    A user with valid credentials must be able to login.
    New Browser    browser=${BROWSER}    headless=False
    New Context    viewport=${None}    locale=de-DE
    New Page    ${URL}
    Login    ${USERNAME}    ${PASSWORD}    expectfail=False

Login with invalid credentials
    [Documentation]    A user with valid credentials must be able to login.
    New Browser    browser=${BROWSER}    headless=False
    New Context    viewport=${None}    locale=de-DE
    New Page    ${URL}
    Login    ${USERNAME}    thisisanincorrectpassword!    expectfail=True

Search Item And Add To Basket
    [Documentation]    Searches an article, adds it to the basket and tries to navigate to the checkout page.
    No Operation


*** Keywords ***
Login
    [Documentation]    Performs a login with the given username/password.   
    ...    Depending on the expectfail parameter, an error or success is expected.
    [Arguments]    ${username}    ${password}    ${expectfail}=False    #  <--HERE--   by default, assume the test of a successful login
    Click
    ...    div.service-menu > button
    Fill text
    ...    input#loginEmail
    ...    ${username}
    Fill text    input#loginPasword    ${password}
    Click    div.service-menu form button
    IF    ${expectfail} == ${True}    #  <--HERE--  
        # invalid credentials, we expect an errror
        # Asserting a certain error message as in the ELSE part would be possible, but then we depend 
        # on the exact verbalization of an error message we have no control over.
        # Instead we ignore the concrete text, and simply check the visibility of the paragraph around it. 
        Get Element States   # returns a list of all states (attached, visible, disabled, readonly, ....)
        ...    p#errorBadLogin  #  <p> element with ID attribute "errorBadLogin"
        ...    *=
        ...    visible  # "visible" must be in list
        ...    message="Did not receive expected error after login attempt with invalid credentials!"
    ELSE
        # valid credentials, successful login    #  <--HERE--  
        Get Text    div.service-menu > button    *=    Mein Konto    message="Login failed!"
    END    



# BAD EXAMPLE for code duplication - only the last keyword call is different from the "Login" keyword.     #  <--HERE--  
# Invalid Login
#     [Documentation]    Performs an invalid login 
#     [Arguments]    ${username}    ${password}   
#     Click
#     ...    div.service-menu > button
#     Fill text
#     ...    input#loginEmail
#     ...    ${username}
#     Fill text    input#loginPasword    ${password}
#     Click    div.service-menu form button
#     Get Element States   # returns a list of all states (attached, visible, disabled, readonly, ....)
#         ...    p#errorBadLogin  #  <p> element with ID attribute "errorBadLogin"
#         ...    *=
#         ...    visible  # "visible" must be in list
#         ...    message="Did not receive expected error after login attempt with invalid credentials!"
