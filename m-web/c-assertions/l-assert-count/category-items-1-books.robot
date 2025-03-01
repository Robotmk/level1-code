*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://ginandjuice.shop/catalog


*** Test Cases ***

Test Product Category Content
    # Navigate to the "books" category
    # Count the articles in category "books"
    No Operation
    

