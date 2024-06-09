*** Settings ***
Library     Browser

*** Test Cases ***
Fill In Search On Playwright
    New Browser    headless=False
    New Context    locale=en-US
    New Page    url=https://playwright.dev
    Click  button.DocSearch-Button
    Fill Text  input.DocSearch-Input  download
    Keyboard Key  press  Enter

Type Delayed Search On Playwright
    New Browser    headless=False
    New Context    locale=en-US
    New Page    url=https://playwright.dev
    Click  button.DocSearch-Button
    Type Text  input.DocSearch-Input  download  delay=400 ms
    Press Keys  input.DocSearch-Input  Enter