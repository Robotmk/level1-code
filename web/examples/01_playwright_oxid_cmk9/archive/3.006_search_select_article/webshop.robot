*** Comments ***
-> Add third test (artice search) 

Key Learnings:
- Multiple Arguments
- CSS chaining
- Comparing strings

The third test should search for a specific article ID and check if the ordering process until before payment works.
It is highly recommended to store such dynamic data in variables instead of hardcoding them into the test. 

#  !!ACTION: Debug the 3rd test case and inspect the selectors. Change ARTICLE_PRICE and see if the error message is correct. 

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
    Search And Select Article    #  <--HERE--  
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
    [Documentation]    Performans an article query and opens the first mathcing item.
    [Arguments]    ${article_id}    ${article_title}    ${article_price}  
    Fill Text    input#searchParam    ${article_id}    #  <--HERE--  enter the ID into the searchbox 
    Click    form.search button  # CSS: a <button> inside of a <form> with class "search"
    
    # Check if the 1st element of the results is the expected one.
    # Read from right to left: 
    # - a <div> with class 'productData', which is the first child element of 
    # - a <div> with class 'row'        , which is the first child element of 
    # - a <div> with class 'list-container'
    Get Text    div.list-container div.row:first-child div.productData:first-child    *=    ${article_title}   message=Article ${article_id} cannot be found!
    
    # Select the 1st article; uses the same selector as above + <a> inside of a <div>
    Click    div.list-container div.row:first-child div.productData:first-child div.actions a
    
    # Check if the details page shows the article text
    Get Text    div.detailsInfo    *=    ${article_title}  message=Article ${article_id} cannot be found!
    
    # Add the item to the basket
    Click    button#toBasket
    
    # CSS: click on the <a> link which has a "title" attribute with the given text
    Click    a[title='Warenkorb zeigen']

    # Check the article price in the table and produce a meaningful error message
    Get Text    td#basketGrandTotal    ==    ${article_price}  message=Price for article ${article_id} is {value} (expected:{expected})!