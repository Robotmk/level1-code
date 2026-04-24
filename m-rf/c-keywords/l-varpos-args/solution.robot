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
    [Arguments]    ${type}    @{items}    ${size}=medium
    Log    Packing a ${size} ${type} with these items: 
    Log Many  @{items}