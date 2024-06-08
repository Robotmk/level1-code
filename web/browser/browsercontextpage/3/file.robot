*** Settings ***
Library  Browser

*** Test Cases ***

A New Visible Browser
    New Browser  browser=firefox  headless=False
    New Context  viewport={"width": 800, "height": 600}  locale=en-US
    New Page  url=https://robotframework.org