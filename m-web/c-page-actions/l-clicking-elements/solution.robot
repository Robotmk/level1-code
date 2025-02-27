*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://coffee-cart.app

*** Test Cases ***

Order Two Coffee
    Click  data-test=Espresso
    Click  data-test=Cafe_Latte
    Click  text=cart (2)
    Click  button[aria-label='Remove all Cafe Latte']
    Click  button[aria-label='Remove all Espresso']