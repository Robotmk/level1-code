*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Init
Test Setup  Session Init  ${URL}

*** Variables ***
${URL}  https://playwright.dev


*** Test Cases ***
Quick Search On Playwright
    Click  button.DocSearch-Button
    Fill Text  input#docsearch-input  download
    Keyboard Key  press  Enter

Delayed Search On Playwright
    # (sends the shortcut to the nav bar)
    Press Keys  nav  CTRL+K
    Type Text  input#docsearch-input  download  delay=400 ms
    Press Keys  input#docsearch-input  Enter