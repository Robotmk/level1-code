*** Comments ***
-> Empty basket before ordering

Key Learnings:
- use internal text strategy to locate elements 
- Strict mode (https://marketsquare.github.io/robotframework-browser/Browser.html#Finding%20elements)
- Conditional Actions based on "then"-Assertions

Even if Playwright always starts the browser with a fresh incognito profile, a test should never rely
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
Documentation       Oxid eshop test for login and item search.

Library             Browser  enable_presenter_mode={"duration": "1 seconds", "width": "6px", "style": "dotted", "color": "red"}
Library             CryptoLibrary    password=%{ROBOT_CRYPTO_KEY_PASSWORD_OXID}
...                     variable_decryption=True    key_path=${CURDIR}${/}keys

Test Setup          Open Webshop 


*** Variables ***
${URL}          https://oxid.robotmk.org
${BROWSER}      chromium
${USERNAME}     mail@robotmk.org
${PASSWORD}     crypt:bD22YdO6Om/M63SHz3clvZ4UKpEonuvUh0nO+vHymmFGWjzPveg+dSTFGlVRmSk7ZQQj7anvpBA=    #

# ARTICLE
${ARTICLE_ID}  2402
${ARTICLE_TITLE}   Bindung LIQUID FORCE TRANSIT BOOT
${ARTICLE_PRICE}   259,00 €

*** Test Cases ***
Login with valid credentials
    [Documentation]    A user with valid credentials must be able to login.
    Login    ${USERNAME}    ${PASSWORD}    expectfail=False

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
    Get Text    div.list-container div.row:first-child div.productData:first-child    *=    ${article_title}   message=Article ${article_id} cannot be found!
    Click    div.list-container div.row:first-child div.productData:first-child div.actions a
    Get Text    div.detailsInfo    *=    ${article_title}  message=Article ${article_id} cannot be found!
    Click    button#toBasket
    Click    a[title='Warenkorb zeigen']
    Get Text    td#basketGrandTotal    ==    ${article_price}  message=Price for article ${article_id} is {value} (expected:{expected})!

Empty Basket
    [Documentation]    Removes all items from the basket.    #  <--HERE--  
    # Beneath CSS and Xpath, you can also use text= or id= as internal selector strategies of Playwright. 
    # Be aware that there are different ways to locate Text: 
    # 1) substring
    # Click    text=Warenkorb    # NOT POSSIBLE - returns 5 results!
    # 2) Regex - most flexible
    # Click    text=/^(Waren|Einkaufs)korb$/    # POSSIBLE with regex
    # 3) Exact text 
    Click    text="Warenkorb" 

    # ${basket_empty-warning}=  Get Element States    div#empty-basket-warning    *=    visible
    # The line above would throw an exception if the "empty" message is not visible. In order to proceed with 
    # the test in _any_ case, we use an advanced trick to use bitwise AND flag operation. 
    # Explanation:
    # Get Element States    div#empty-basket-warning
    # returns the list of ElementStates enum: 
    # - ['attached', 'visible', 'enabled', 'editable', 'defocused'] if it is visible
    # - ['detached'] if it is not visible
    # "then" as an assertion operator allows to be followed by a Python expression which can handle the  ElementState enum (stored in "value").
    # bool(value & visible) returns if the bitwise bitwise AND operation was successful.

    # Set a BREAKPOINT here
    ${basket_is_empty}=    Get Element States    div#empty-basket-warning    then  bool(value & visible)
    IF  not ${basket_is_empty}
        # Checkbox for all items
        Click    button#basketRemoveAll
        # Button to remove
        Click    button#basketRemove
        Get Element States    div#empty-basket-warning    *=    visible    message=Basket could not be cleared!
    END
    # Return to the shop landing page
    Go To    ${URL}