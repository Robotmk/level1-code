*** Comments ***
Objective: Screenshots

Key Learnings: 
- Learn how to embed screenshots taken by the library both in case of an error and on demand.
- mask & selective screenshots


For monitoring Admins it is very important to have one central UI form where they can read the status
of ALL systems. If an end2end test fails, it is very helpful to have a screenshot of the failed state
contained in the HTML log file. Browser Library allows to do this, and also can add screenshots on
demand for documentation purposes.

In this checkpoint, we change the default error action (take screenshot and store on disk) to
our own (take screenshot, do not store, but embed in the HTML log).
We also add two screenshots to document the successful login and the final cart view.

#    !!ACTION: Run the test and check if the HTML log contains two screenshots.
Then sabotage any element selector (e.g. the one in after the line CHANGETHIS) and run again.
The test should FAIL and in the log you should see the screenshot of the application's state just in the moment the error occurred.
Also uncomment the two lines below of UNCOMMENT and see the possibilities for masking and selective screenshots.

Pro tipp: instead of opening log.html, you can stay within VS Code and use the tab "ROBOT OUTPUT".
RF language server parses the XML of each execution und provides a condensed view of the execution log,
still containing all screenshots!

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
