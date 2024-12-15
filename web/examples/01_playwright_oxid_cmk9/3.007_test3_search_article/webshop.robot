*** Comments ***
Objective: test3  (article search)

Key Learnings: 
- Multiple Arguments
- CSS chaining
- Comparing strings

The third test should search for a specific article ID and check if the ordering process until before payment works.
It is highly recommended to store such dynamic data in variables instead of hardcoding them into the test. 

#  !!ACTION: Debug the 3rd test case and inspect the selectors. Change ARTICLE_PRICE and see if the error message is correct. 



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
    Search And Select Article    #  <--HERE--  
    ...    article_id=${ARTICLE_ID}
    ...    article_title=${ARTICLE_TITLE}
    ...    article_price=${ARTICLE_PRICE}