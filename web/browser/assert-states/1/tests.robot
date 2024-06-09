*** Settings ***
Library  Browser   strict=False

*** Variables ***
${CSS_LOGO}  h1 svg#face
${CSS_CHECKBOX}  input:nth-of-type

*** Test Cases ***

Test RobotFramework Logo Visibility
    New Browser  browser=firefox  headless=False
    New Context  locale=en-US
    New Page    url=https://robotframework.org
    ${states}=  Get Element States  ${CSS_LOGO}
    Log Many  ${states}
    Get Element States  ${CSS_LOGO}   validate  value & visible
    ...  msg=ERROR: RF Logo in Headline not found!

Test Checkbox State
    [Documentation]  Verifies that Checkboxes are in the correct state
    New Browser  browser=firefox  headless=False
    New Context  locale=en-US
    New Page    url=https://the-internet.herokuapp.com/checkboxes
    Get Element States  ${CSS_CHECKBOX}(1)   validate  value & unchecked
    ...  msg=ERROR: Checkbox 1 is not unchecked!
    Get Element States  ${CSS_CHECKBOX}(2)   validate  value & checked
    ...  msg=ERROR: Checkbox 2 is not checked!