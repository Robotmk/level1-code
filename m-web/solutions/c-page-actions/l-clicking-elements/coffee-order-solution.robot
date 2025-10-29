*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://coffee-cart.app

*** Test Cases ***

Order Two Coffee
    # Deletes the coffees by the button name
    Click  data-test=Espresso
    Click  data-test=Cafe_Latte
    Click  [aria-label='Cart page']
    Click  [aria-label='Remove all Cafe Latte']
    Click  [aria-label='Remove all Espresso']

# ------------------------------
# These examples show different ways to delete all coffee orders using a WHILE loop

Order Two Coffee2
    # Delete the coffee orders with a WHILE loop 
    # Requires to disable Strict Mode
    Click  data-test=Espresso
    Click  data-test=Cafe_Latte
    Click  data-test=Cappuccino
    Click  data-test=Americano
    Click  [aria-label='Cart page']
    Set Strict Mode    ${False}
    ${exists}=  Get Element States  button.delete  evaluate  'visible' in value.name
    WHILE  ${exists}
        Click  button.delete
        ${exists}=  Get Element States  button.delete  evaluate  'visible' in value.name
    END
    

Order Two Coffee3
    # Delete the coffee orders with a WHILE loop
    # Uses Get Element Count
    Click  data-test=Espresso
    Click  data-test=Cafe_Latte
    Click  data-test=Cappuccino
    Click  data-test=Americano
    Click  [aria-label='Cart page']
    ${count}=  Get Element Count  button.delete
    WHILE  ${count}
        Click  (//button[@class='delete'])[1]
        ${count}=  Get Element Count  button.delete
    END
    