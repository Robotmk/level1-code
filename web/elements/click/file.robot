*** Settings ***
Library     Browser


*** Test Cases ***
Open Robocon24 Page
    New Browser    headless=False
    New Context    locale=en-US
    New Page    url=https://robotframework.org/
    Click    div.intro >> "Robot Framework Foundation"
    Click    "RoboCon"
    Click    button.hamburger
    Click    text=RBCN24
