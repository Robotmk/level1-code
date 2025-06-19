*** Settings ***
Resource  ./Resources/BrowserCommon.resource
Suite Setup  Browser Init  
Test Setup  Session Init  url=${URL}

*** Variables ***
${URL}  https://react-shopping-cart-67954.firebaseapp.com
@{ARTICLES}=  
...  Skater Black Sweatshirt
...  Black Batman T-shirt
...  Tropical Wine T-shirt

*** Test Cases ***

    
Add Items to Cart and Verify
    [Documentation]    Adds an item to the cart and verifies it appears.
    Add Items To Cart  @{ARTICLES}
    Verify Cart   @{ARTICLES}

Check Amount Per Size
    [Documentation]  Verifies that there is at least 1 product per size available.
    ${size_elements}=  Get Sizes
    FOR  ${size}  IN  @{size_elements}
        Verify Amount  ${size}
    END


*** Keywords ***

Verify Amount
    [Documentation]  Click the size button and verify amount. In ANY case, deselect the size button. 
    [Arguments]  ${size}
    [Teardown]  Click  ${size}
    Click  ${size}
    Get Text  
    ...    //p[contains(.,'Product(s) found')]  matches  ^[0-9]+ Product.*
    ...    message=Size ${size} does not contain at least 1 product.

Add Items To Cart
    [Arguments]  @{articles}
    FOR  ${article}  IN  @{articles}
        Add To Cart  title=${article}
        Close Cart
    END

Add To Cart
    [Arguments]  ${title}
    Click  //div[@alt='${title}']/following-sibling::button  

Open Cart
    Click  div[title='Products in cart quantity'] >> ../../../button

Verify Cart
    [Arguments]  @{articles}
    Open Cart
    FOR  ${article}  IN  @{ARTICLES}
        Get Text  text="Cart" >> ../../div[2]  contains  ${article}  message=Article {expected} not found
    END

Get Sizes
    ${size_elements}=  Get Elements  //h4[text()='Sizes:']/following-sibling::div
    RETURN  ${size_elements}

Close Cart
    Run Keyword And Ignore Error   Click   "X"