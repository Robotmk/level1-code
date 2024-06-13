*** Settings ***
Library  Browser

*** Test Cases ***

Open RobotFramework Page
    New Browser  browser=firefox  headless=False
    New Context  locale=en-US
    New Page    url=https://robotframework.org
    Set Strict Mode  False
    Click  a 