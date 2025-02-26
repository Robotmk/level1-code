*** Comments ***
-> Avoid code duplications

Key Learnings:
- Setup/Teardown in Suite and Tests

Both Tests (valid/invalid Login) contain redundant keywords just to open the web shop's landing page.
Even worse, "New Browser" wastes time/resources because it is enough to create a new _context_ for each test
(which includes a new page).

As this is not a relevant part of the test (indeed, it's a precondition), we can move these keywords out
into Robot Framework hooks for setup/teardown.

If you are wondering why we do not have to "close" the contexts of tests: by default, Browser Library auto-closes
the contexts at the very end of each test (https://marketsquare.github.io/robotframework-browser/Browser.html#Automatic%20page%20and%20context%20closing)

#  !!ACTION: Execute the suite - it should work as before, but with much less boilerplate code in the tests.

*** Settings ***
Documentation       Oxid eshop test for login and item search.

Library             Browser  enable_presenter_mode={"duration": "1 seconds", "width": "6px", "style": "dotted", "color": "red"}
Library             CryptoLibrary    password=%{ROBOT_CRYPTO_KEY_PASSWORD_OXID}
...                     variable_decryption=True    key_path=${CURDIR}${/}keys

Test Setup          Open Webshop    #    <--HERE--    This user keyword is called just before each test


*** Variables ***
${URL}          https://oxid.robotmk.org
${BROWSER}      chromium
${USERNAME}     mail@robotmk.org
${PASSWORD}     crypt:bD22YdO6Om/M63SHz3clvZ4UKpEonuvUh0nO+vHymmFGWjzPveg+dSTFGlVRmSk7ZQQj7anvpBA=    #


*** Test Cases ***
Login with valid credentials
    [Documentation]    A user with valid credentials must be able to login.
    #    <--HERE--    Removed New Browser/Context/Page
    Login    ${USERNAME}    ${PASSWORD}    expectfail=False

Login with invalid credentials
    [Documentation]    A user with valid credentials must be able to login.
    #    <--HERE--    Removed New Browser/Context/Page
    Login    ${USERNAME}    thisisanincorrectpassword!    expectfail=True

Search Item And Add To Basket
    [Documentation]    Searches an article, adds it to the basket and tries to navigate to the checkout page.
    No Operation


*** Keywords ***
Login
    [Documentation]    Performs a login with the given username/password.
    ...    Depending on the expectfail parameter, an error or success is expected.
    [Arguments]    ${username}    ${password}    ${expectfail}=False
    Click
    ...    div.service-menu > button
    Fill text
    ...    input#loginEmail
    ...    ${username}
    Fill text    input#loginPasword    ${password}
    Click    div.service-menu form button
    IF    ${expectfail} == ${True}
        Get Element States
        ...    p#errorBadLogin
        ...    *=
        ...    visible
        ...    message="Did not receive expected error after login attempt with invalid credentials!"
    ELSE
        Get Text    div.service-menu > button    *=    Mein Konto    message="Login failed!"
    END

Open Webshop    #    <--HERE--    This new keyword is used before each test starts.
    [Documentation]    Opens the web shop's landing page
    New Browser    browser=${BROWSER}    headless=False
    New Context    viewport=${None}    locale=de-DE
    New Page    ${URL}
