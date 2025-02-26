*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}
# Define a template keyword with embedded argument,
# executed for each iteration
Test Template  Verify Amount Of "${category}" Category

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
    # Leveraging "Template with FOR loops": executes the template keyword for each iteration
    # https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#templates-with-for-loops
    # https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#all-top-level-keywords-are-executed-when-tests-have-templates
    # In this mode, continue-on-failure is enabled by default
    FOR  ${category}  IN  @{CATEGORIES}
        ${category}
    END
    
*** Keywords ***

Verify Amount Of "${category}" Category
    # Navigate to the category
    Click  "${category}"
    Get Element Count  
    ...    ${SEL_CATEGORY}  >=  3
    ...    message=Expected at least {expected} articles in category ${category}, found {value}.