*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://ginandjuice.shop/catalog
# Article links inside the category listing
${SEL_CATEGORY}  //section[@class='container-list-tiles']/a[starts-with(@href, '/catalog/product')]

*** Test Cases ***

Book Category Should Contain Min 3 Articles
    VAR  ${category}  Books
    Click  "${category}"
    Get Element Count  
    ...    ${SEL_CATEGORY}  >=  3
    ...    message=Expected at least {expected} articles in category ${category}, found {value}.
    


    

