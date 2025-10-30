*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://ginandjuice.shop/catalog
${SEL_CATEGORY}  //section[@class='container-list-tiles']/a[starts-with(@href, '/catalog/product')]
@{CATEGORIES}  
...    Accessories  
...    Accompaniments
...    Books
...    Gin
...    Juice

*** Test Cases ***

Every Category Should Contain Min 3 Articles
    [Tags]    robot:continue-on-failure
    FOR  ${category}  IN  @{CATEGORIES}
        Verify Amount Of Category  ${category}
    END
    
*** Keywords ***

Verify Amount Of Category
    [Arguments]  ${category}
    Click  "${category}"
    Get Element Count  
    ...    ${SEL_CATEGORY}  >=  3
    ...    message=Expected at least {expected} articles in category ${category}, found {value}.