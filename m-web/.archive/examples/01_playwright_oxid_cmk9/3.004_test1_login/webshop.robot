*** Comments ***
Objective: User keyword "login", CryptoLibrary

Key Learnings:
- using Environment variables
- Built-In variables ${CURDIR} and ${/}
- variable scope, casing
- creating keypair with CryptoLibrary
- Selector strategy, Strict mode on/off

Never store sensitive information within the robot file. Instead, use CryptoLibrary to encrypt passwords etc.
The library will use a password-secured private key to decrypt all secrets with the preamble "crypt:".

!!ACTION: Set a breakpoint at "BREAK" and start the debugger. Press F11 to step into the keyword and
see how the Login is done.


*** Settings ***
Documentation       This suite contains tests to verify that login
...                 and basic basket/ordering functionality is working.

Resource            webshop_oxid.resource
Library             Browser
Library             CryptoLibrary    password=%{ROBOT_CRYPTO_KEY_PASSWORD_OXID}
...                     variable_decryption=True    key_path=${CURDIR}${/}keys    #    <--HERE-- ${CURDIR}=dir of .robot file / ${/}=special var to be OS independent 


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
    Login    ${USERNAME}    ${PASSWORD}    #    <--BREAK--

Login with invalid credentials
    [Documentation]    The purpose of this test case is to verify that a user with invalid credentials
    ...    cannot log into the shop system.
    No Operation

Search Item And Add To Basket
    [Documentation]    The purpose of this test case is to verify that a user can search for an item,
    ...    add it into the basket and get an expected total price.
    No OperationFill Text  


*** Keywords ***
Login
    #    <--HERE--    The Login keyword encapsulates the keywords needed to perform a login.
    [Documentation]    Performs a login with the given username/password.
    [Arguments]    ${uname}    ${pwd}     #    <--HERE--    convention: within keyword scope, always use lowercase var names
    Click    ${MENU_BT_ANMELDEN1}
    Fill text    ${MENU_F_USERNAME}    ${uname}
    Fill text    ${MENU_F_PASSWORD}    ${pwd}
    Click    ${MENU_BT_ANMELDEN2}
    Get Text    ${MENU_BT_ACCOUNT}    *=    Mein Konto    message="Login failed!"
