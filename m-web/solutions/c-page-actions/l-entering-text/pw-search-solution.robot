*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Init
Test Setup  Session Init  ${URL}

*** Variables ***
${URL}  https://playwright.dev


*** Test Cases ***
Quick Search On Playwright
    Click  button.DocSearch-Button
    Fill Text  input.DocSearch-Input  download
    Keyboard Key  press  Enter

Delayed Search On Playwright
    Click  button.DocSearch-Button
    Type Text  input.DocSearch-Input  download  delay=400 ms
    Press Keys  input.DocSearch-Input  Enter