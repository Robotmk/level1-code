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
    Get Element States  ${CSS_LOGO}   contains  visible
    ...  message=ERROR: RF Logo in Headline not found!

Test Checkbox State
    [Documentation]  Verifies that Checkboxes are in the correct state
    New Browser  browser=firefox  headless=False
    New Context  locale=en-US
    New Page    url=https://the-internet.herokuapp.com/checkboxes
    Get Element States  ${CSS_CHECKBOX}(1)   contains  unchecked
    ...  message=ERROR: Checkbox 1 is not unchecked!
    Get Element States  ${CSS_CHECKBOX}(2)   contains  checked
    ...  message=ERROR: Checkbox 2 is not checked!