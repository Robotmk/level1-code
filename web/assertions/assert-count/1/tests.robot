*** Settings ***
Library  Browser

*** Variables ***
${CSS_SPONSORS}  a.sponsor

*** Test Cases ***

Test RobotFramework Sponsor Count
    New Browser  browser=firefox  headless=False
    New Context  locale=en-US
    New Page    url=https://robotframework.org
    Get Element Count  ${CSS_SPONSORS}  >=  60