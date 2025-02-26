*** Settings ***
Library  Browser   strict=False

*** Test Cases ***

Open RobotFramework Page
    New Browser  browser=firefox  headless=False
    New Context  locale=en-US
    New Page    url=https://robotframework.org
    Click  a 