*** Comments ***
-> Create Login keyword for Oxid eshop
-> Handle sensitive data 


Key Learnings: 
- Variables
- CryptoLibrary
- Selector strategy, Strict mode on/off
- CSS/XPath selectors

You should never store sensitive information within the robot file. Instead, use CryptoLibrary
to encrypt passwords etc. (https://snooz82.github.io/robotframework-crypto/CryptoLibrary.html)
The library will use a password-secured private key to decrypt all secrets with the preamble "crypt:".

It's the first time here we use selectors to access elements on the page.
Read more about the selector strategy here: https://marketsquare.github.io/robotframework-browser/Browser.html#Finding%20elements
CSS selectors are preferred, the are less "noisy" and easier to read. However, there are cases
where XPath selectors are still useful.
Assertions in Browser Library: https://marketsquare.github.io/robotframework-browser/Browser.html#Assertions

Train yourself in CSS selectors:    https://flukeout.github.io
Train yourself in XPath selectors: https://topswagcode.com/xpath/

!!ACTION: Set a breakpoint in Line 44 and start the debugger. Press F11 to step into the keyword and 
see how the Login is done. 


*** Settings ***
Documentation       Oxid eshop test for login and item search.

Library             Browser
# - %{} acesses environment variables
# - variable_decryption controls whether all crypt: variables should be decrypted automatically (recommended).
#    If False, you have to decrypt each secret manually with "Get Decrypted Text"
# - key_path is a subfolder in the project dir. It is safe to store the key in Git because the
#    private key's password is not included.
Library             CryptoLibrary    password=%{ROBOT_CRYPTO_KEY_PASSWORD_OXID}
...                     variable_decryption=True    key_path=${CURDIR}${/}keys    #    <--HERE-- ${CURDIR}=dir of .robot file / ${/}=special var to be OS independent 


*** Variables ***
${URL}          https://oxid.robotmk.org
${BROWSER}      chromium
${USERNAME}     mail@robotmk.org    #    <--HERE--
${PASSWORD}     crypt:bD22YdO6Om/M63SHz3clvZ4UKpEonuvUh0nO+vHymmFGWjzPveg+dSTFGlVRmSk7ZQQj7anvpBA=    #    <--HERE--


*** Test Cases ***
Login with valid credentials
    [Documentation]    A user with valid credentials must be able to login.
    New Browser    browser=${BROWSER}    headless=False
    New Context    viewport=${None}    locale=de-DE
    New Page    ${URL}
    Login    ${USERNAME}    ${PASSWORD}    #    <--HERE--
    No Operation

Login with invalid credentials
    [Documentation]    A user with valid credentials must be able to login.
    No Operation

Search Item And Add To Basket
    [Documentation]    Searches an article, adds it to the basket and tries to navigate to the checkout page.
    No Operation


*** Keywords ***
Login
    [Documentation]    Performs a login with the given username/password.    #    <--HERE--    The Login keyword encapsulates the keywords needed to perform a login.
    [Arguments]    ${username}    ${password}    #    <--HERE--    within keyword scope, we use lowercase var names
    # Does not work with Strict mode on (3 results)
    # Click  text="Anmelden"

    # CSS: "A <button> tag which is a direct child of a <div> with the class 'service-menu' "
    Click
    ...    div.service-menu > button
    # CSS: "An <input> tag which has the ID attribute 'loginEmail' / 'loginPassword'"
    Fill text
    ...    input#loginEmail
    ...    ${username}
    Fill text    input#loginPasword    ${password}
    # CSS: "A <button> tag which is within a <form> tag which is within a <div> with the class 'service-menu'"
    Click    div.service-menu form button

    # Our first Assertion: Assertions do not perform actions on the page but only check 
    # if it has the desired state. Assertions are not needed inevitably and in every case, 
    # but often make tests more stable and the results more readable. 
    # "Get Text"  simply returns the text of an element. 
    # But combined with an assertion operator, it can compare this text with a given one
    # and throw a proper error.   
    Get Text    div.service-menu > button    *=    Mein Konto    message="Login failed!"
