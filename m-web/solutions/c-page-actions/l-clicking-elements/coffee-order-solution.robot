*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://coffee-cart.app

*** Test Cases ***

Order Two Coffee
    Click  data-test=Espresso
    Click  data-test=Cafe_Latte
    Click  [aria-label='Cart page']
    Click  [aria-label='Remove all Cafe Latte']
    Click  [aria-label='Remove all Espresso']