*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://ginandjuice.shop/catalog
# Article links inside the category listing
${SEL_CATEGORY}  //section[@class='container-list-tiles']/a[starts-with(@href, '/catalog/product')]


*** Test Cases ***

Book Category Should Contain Min 3 Articles
    # Write this test to check that **category 'Books'** contains at least 3 books.  
    # If not, the message should be: 'Expected at least 3 articles in category Books, found 2.''
    
    # -> Navigate to the "books" category
    No Operation
    # -> Count the articles in category "books", use ">=" for the assertion,
    # and provide a custom error message which contains the Category name.
    # (The selector is provided in the variables section)
    No Operation
    

