*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://coffee-cart.app

*** Test Cases ***

Order Two Coffee
    No Operation
    # Order 1 Cafe Latte
    # Order 1 Espresso
    # Go to Basket
    # Remove both items