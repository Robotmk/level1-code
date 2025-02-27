*** Comments ***
-> Include resource file

Key Learnings:
- How to use resource files
- write abstract Robot code
- use test teardown to take a screenshot at the end of every test

This checkpoint is completely optional but gives an insight about how a higher abstraction level
can help to write better code. "Abstraction" means concretely that
- the main robot file (=this) only contains the "test instructions" (=the keyword calls) of how to do the test in a human readable form.
- the implementation (=the keywords) gets read from another "resource" file which contains the technical stuff.

There are two major motiviations to do this:
- It keeps your main robot file more condensed so that it is much easier to see at a glance what's happening.
- Keeping the technical stuff out of the main file makes it easy to implement the test with another technology (e.g. SeleniumLibrary).
    All you have to do then is to import another resource file - the keyword names remain the same.

Hint: as long as the keyword names are unique, you can call "Login" from the main file without problems.
In case there is already a keyword "Login" in the main file but you want to call the external one, you can write:
webshop_oxid.Login


*** Settings ***
Documentation       Oxid eshop test for login and item search.

Resource            webshop_oxid.resource    #    <--HERE--    This imports the Robot code from the resource file
Library             CryptoLibrary    password=%{ROBOT_CRYPTO_KEY_PASSWORD_OXID}
...                     variable_decryption=True    key_path=${CURDIR}${/}keys

Test Setup          Open Webshop
Test Teardown       Take A Screenshot    #    <--HERE--


*** Variables ***
${BROWSER}          chromium
${ARTICLE_ID}       2402
${ARTICLE_TITLE}    Bindung LIQUID FORCE TRANSIT BOOT
${ARTICLE_PRICE}    259,00 €


*** Test Cases ***
Login with valid credentials
    [Documentation]    A user with valid credentials must be able to login.
    Login

Login with invalid credentials
    [Documentation]    A user with invalid credentials must be rejected.
    Login    pwd=thisisanincorrectpassword!    expectfail=True

Search Item And Add To Basket
    [Documentation]    Searches an article, adds it to the basket and tries to navigate to the checkout page.
    Empty Basket
    Search And Select Article
    ...    article_id=${ARTICLE_ID}
    ...    article_title=${ARTICLE_TITLE}
    ...    article_price=${ARTICLE_PRICE}


*** Keywords ***
Take A Screenshot
    [Documentation]    Custom implementation to take a screenshot
    Take Screenshot    EMBED
