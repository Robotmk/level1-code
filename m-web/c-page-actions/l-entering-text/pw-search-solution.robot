*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://playwright.dev


*** Test Cases ***
Fill In Search On Playwright
    Click  button.DocSearch-Button
    Fill Text  input.DocSearch-Input  download
    Keyboard Key  press  Enter

Type Delayed Search On Playwright
    Click  button.DocSearch-Button
    Type Text  input.DocSearch-Input  download  delay=400 ms
    Press Keys  input.DocSearch-Input  Enter