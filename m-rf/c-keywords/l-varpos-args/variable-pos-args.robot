*** Test Cases ***
Test One
    Pack the Luggage    bag    sunglasses  size=xs
    Pack the Luggage    bag   
    ...    iphone  keys  lipstick
    ...    pen  earphones  hand cream  
    Pack the Luggage    suitcase    
    ...    shirts  socks  shoes  underwear  ebook  dress
    ...    pants  shoes swimwear  coat  laundry bag  towel
    ...    size=xl

*** Keywords ***
Pack the Luggage
    # => complete the arguments
    [Arguments]   
    # => Use "Log" to log the kind and size of the bag.
    
    # => Use "Log Many" to log the items 
    