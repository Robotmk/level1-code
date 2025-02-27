*** Comments ***
Objective: Presenter mode

Key Learnings: 
- Learn how to activate the presenter mode
- Use it to debug

This is completely optional and not required for production. 
Presenter mode is a feature that allows you to replay your tests
slower and with accessed elements highlighted. This is useful for
debugging and for presentations.

!! ACTION: Change a selector so that it is broken and run the test.
See what happens in the presenter mode.


*** Settings ***
Documentation       This suite contains tests to verify that login
...                 and basic basket/ordering functionality is working.

Resource            webshop_oxid.resource
Library             Browser
Library             CryptoLibrary    password=%{ROBOT_CRYPTO_KEY_PASSWORD_OXID}
...                     variable_decryption=True    key_path=${CURDIR}${/}keys   

Test Setup          Open Webshop   


*** Variables ***
${BROWSER}      chromium

${ARTICLE_ID}  2402
${ARTICLE_TITLE}   Bindung LIQUID FORCE TRANSIT BOOT
${ARTICLE_PRICE}   259,00 €

*** Test Cases ***
Login with valid credentials
    [Documentation]    The purpose of this test case is to verify that a user can successfully log
    ...    in to the application using valid credentials.
    Login    ${USERNAME}    ${PASSWORD} 
    Take Screenshot    EMBED    #    <--HERE--  

Login with invalid credentials
    [Documentation]    The purpose of this test case is to verify that a user with invalid credentials
    ...    cannot log into the shop system.
    Login    ${USERNAME}    thisisanincorrectpassword!    expectfail=True

Search Item And Add To Basket
    [Documentation]    Searches an article, adds it to the basket and tries to navigate to the checkout page.
    Empty Basket
    Search And Select Article   
    ...    article_id=${ARTICLE_ID}
    ...    article_title=${ARTICLE_TITLE}
    ...    article_price=${ARTICLE_PRICE}
    Take Screenshot    EMBED    #    <--HERE--
    # UNCOMMENT to test masking and selective screenshots
    # Take Screenshot    EMBED    mask=footer    # !!ACTION    Try this: the screenshot will contain a mask above the footer (useful to hide sensitive data)
    # Take Screenshot    EMBED    selector=form#basket_form    # !!ACTION    and this: the screenshot will be taken only the table with the basket
