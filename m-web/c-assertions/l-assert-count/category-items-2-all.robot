*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://ginandjuice.shop/catalog
# Storing the selector for the articles
${SEL_CATEGORY}  //section[@class='container-list-tiles']/a[starts-with(@href, '/catalog/product')]
@{CATEGORIES}  
...    Accessories  
...    Accompaniments
...    Books
...    Gin
...    Juice

*** Test Cases ***

Test Product Category Content
    FOR  ${category}  IN  @{CATEGORIES}
        # -> Call the kwd to verify the amount in the category
        No Operation
    END

*** Keywords ***

# -> Create a User keyword to verify the amount of category
