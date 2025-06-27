*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://coffee-cart.app

*** Test Cases ***

Order Two Coffee
    No Operation
    # Order a Cafe Latte
    # Order a Espresso
    # Go to Cart
    # Use the "X" button right of boeth items to remove them all