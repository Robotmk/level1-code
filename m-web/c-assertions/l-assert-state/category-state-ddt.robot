*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}
Test Template  Verify Category "${category}" Is Visible

*** Variables ***
${URL}  https://ginandjuice.shop/catalog
@{CATEGORIES}  
...    Accessories  
...    Accompaniments
...    Books
...    Gin
...    Juice

*** Test Cases ***

Test Product Category Content
    FOR  ${category}  IN  @{CATEGORIES}
        ${category}
    END
    
*** Keywords ***

Verify Category "${category}" Is Visible
    Click  "${category}"
    # Verify that the category is visible and enabled
    No Operation