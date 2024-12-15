*** Comments ***
Objective: Empty the basket before starting the test 

Key Learnings: 
- "then"-Assertions in Browser library

Even if Playwright always starts the browser with a new "incognito" profile, a test should never rely
on preconditions but take care for them. In our case, we should not rely on an empty basket - if there
is already something in, the total price will not be the expected one. 
For this, we introduce another keyword "empty basket" and call it in the test.
There is no need to create a keyword for this task, but it comes with multiple benefits: 
- both the code and result log are more readable
- It makes the code reusable.
- The keyword encapsulation allows to monitor the runtime in Checkmk.

#  !!ACTION: First, run the test and check if it is working. Then set a breakpoint at the line with "BREAKPOINT", 
# run the test and add an item to the basket. Then continue the execution to check if the basket gets cleared. 



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

# ARTICLE VARS   #    <--HERE--   
${ARTICLE_ID}  2402
${ARTICLE_TITLE}   Bindung LIQUID FORCE TRANSIT BOOT
${ARTICLE_PRICE}   259,00 €

*** Test Cases ***
Login with valid credentials
    [Documentation]    The purpose of this test case is to verify that a user can successfully log
    ...    in to the application using valid credentials.
    Login    ${USERNAME}    ${PASSWORD}   

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