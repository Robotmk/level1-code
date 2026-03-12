*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://ginandjuice.shop/catalog
${SEL_CATEGORY}  //section[@class='container-list-tiles']/a[starts-with(@href, '/catalog/product')]
# -> Create a list variable for all categories
# (Accessories,Accompaniments,Books,Gin,Juice)


*** Test Cases ***

Every Category Should Contain Min 3 Articles
    # Extend the test from the previous task (category-items-1-books.robot) so that it checks **all categories**."
    # -> Create a list variable in the variables section
    # -> Iterate over the categories and call the kwd "Verify Amount Of Category".
    # -> Use the special tag "robot:continue-on-failure" to ensure that 
    # even if one category fails, the others are still checked.
    No Operation
      
*** Keywords ***

# -> Create a User keyword "Verify Amount Of Category"
# to verify the amount in the category (=parameter) 
