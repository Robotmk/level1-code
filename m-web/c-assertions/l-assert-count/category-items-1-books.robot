*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://ginandjuice.shop/catalog
# Article links inside the category listing
${SEL_CATEGORY}  //section[@class='container-list-tiles']/a[starts-with(@href, '/catalog/product')]


*** Test Cases ***

Book Category Should Contain Min 3 Articles
    # -> Navigate to the "books" category
    No Operation
    # -> Count the articles in category "books", use ">=" for the assertion,
    # and provide a custom error message which contains the Category name.
    No Operation
    

