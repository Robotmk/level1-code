*** Settings ***
Resource            ../../Resources/BrowserCommon.resource

Suite Setup         Browser Initialization    ${URL}


*** Variables ***
${URL}              https://ginandjuice.shop/catalog
@{CATEGORIES}
...                 Accessories
...                 Accompaniments
...                 Books
...                 Gin
...                 Juice


*** Test Cases ***
Test Product Category Content
    FOR    ${category}    IN    @{CATEGORIES}
        Verify Category Is Visible  ${category}
    END


*** Keywords ***
Verify Category Is Visible
    [Arguments]  ${category}  
    # -> Verify that the category is visible and enabled
    # If not, the message should be:
    # 'The category xxxx is not visible/enabled!' (replace xxx with the category)
    No Operation
