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
    # Without this tag, the test exits with FAIL on category "books".
    # Continue on failure instructs RF to execute all top-level keywords
    # regardless of their result.
    [Tags]    robot:continue-on-failure
    FOR  ${category}  IN  @{CATEGORIES}
        Verify Amount Of "${category}" category
    END
    
*** Keywords ***

Verify Amount Of "${category}" Category
    # Navigate to the category
    Click  "${category}"
    Get Element Count  
    ...    ${SEL_CATEGORY}  >=  3
    ...    message=Expected at least {expected} articles in category ${category}, found {value}.