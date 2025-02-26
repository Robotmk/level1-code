*** Settings ***
Library  Browser  

*** Test Cases ***

Open RobotFramework Page
    New Browser  browser=firefox  headless=False
    New Context  locale=en-US
    New Page    url=https://robotmk-curriculum.robotmk.org
    Click  \#example-frame >>> button.DocSearch-Button