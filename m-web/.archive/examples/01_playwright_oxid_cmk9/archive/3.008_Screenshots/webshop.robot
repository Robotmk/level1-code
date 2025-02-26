*** Comments ***
-> Add screenshots to the log file

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
Documentation       Oxid eshop test for login and item search.

Library             Browser    
...    enable_presenter_mode={"duration": "1 seconds", "width": "6px", "style": "dotted", "color": "red"}    
...    run_on_failure=Take Screenshot \ EMBED    #    <--HERE--
Library             CryptoLibrary    password=%{ROBOT_CRYPTO_KEY_PASSWORD_OXID}
...                     variable_decryption=True    key_path=${CURDIR}${/}keys

Test Setup          Open Webshop


*** Variables ***
${URL}              https://oxid.robotmk.org
${BROWSER}          chromium
${USERNAME}         mail@robotmk.org
${PASSWORD}         crypt:bD22YdO6Om/M63SHz3clvZ4UKpEonuvUh0nO+vHymmFGWjzPveg+dSTFGlVRmSk7ZQQj7anvpBA=    #

# ARTICLE
${ARTICLE_ID}       2402
${ARTICLE_TITLE}    Bindung LIQUID FORCE TRANSIT BOOT
${ARTICLE_PRICE}    259,00 €


*** Test Cases ***
Login with valid credentials
    [Documentation]    A user with valid credentials must be able to login.
    Login    ${USERNAME}    ${PASSWORD}    expectfail=False
    Take Screenshot    EMBED    #    <--HERE--

Login with invalid credentials
    [Documentation]    A user with valid credentials must be able to login.
    Login    ${USERNAME}    thisisanincorrectpassword!    expectfail=True

Search Item And Add To Basket
    [Documentation]    Searches an article, adds it to the basket and tries to navigate to the checkout page.
    Empty Basket
    Search And Select Article
    ...    article_id=${ARTICLE_ID}
    ...    article_title=${ARTICLE_TITLE}
    ...    article_price=${ARTICLE_PRICE}
    Take Screenshot    EMBED    #    <--HERE--
    # UNCOMMENT
    # Take Screenshot    EMBED    mask=footer    # !!ACTION    Try this: the screenshot will contain a mask above the footer (useful to hide sensitive data)
    # Take Screenshot    EMBED    selector=form#basket_form    # !!ACTION    and this: the screenshot will be taken only the table with the basket


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
    # CHANGETHIS selector
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

Open Webshop
    [Documentation]    Opens the web shop's landing page
    New Browser    browser=${BROWSER}    headless=False
    New Context    viewport=${None}    locale=de-DE
    New Page    ${URL}

Search And Select Article
    [Documentation]    Performans an article query and opens the first matching item.
    [Arguments]    ${article_id}    ${article_title}    ${article_price}
    Fill Text    input#searchParam    ${article_id}
    Click    form.search button
    Get Text
    ...    div.list-container div.row:first-child div.productData:first-child
    ...    *=
    ...    ${article_title}
    ...    message=Article ${article_id} cannot be found!
    Click    div.list-container div.row:first-child div.productData:first-child div.actions a
    Get Text    div.detailsInfo    *=    ${article_title}    message=Article ${article_id} cannot be found!
    Click    button#toBasket
    Click    a[title='Warenkorb zeigen']
    Get Text
    ...    td#basketGrandTotal
    ...    ==
    ...    ${article_price}
    ...    message=Price for article ${article_id} is {value} (expected:{expected})!

Empty Basket
    [Documentation]    Removes all items from the basket.
    Click    text="Warenkorb"
    ${basket_is_empty}=    Get Element States    div#empty-basket-warning    then    bool(value & visible)
    IF    not ${basket_is_empty}
        Click    button#basketRemoveAll
        Click    button#basketRemove
        Get Element States    div#empty-basket-warning    *=    visible    message=Basket could not be cleared!
    END
    Go To    ${URL}
