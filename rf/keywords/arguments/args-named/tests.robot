*** Test Cases ***
My Test
    Order Item  Shirt  1  red  M
    Order Item  Pants  51  size=S
    Order Item  Shoes  14  color=black
    # does not work 
    #Order Item  color=black  Shoes  14  size=XL

*** Keywords ***

Order Item
    [Arguments]   ${article}  ${quantity}  ${color}=blue  ${size}=XL
    Log   Ordering now: ${quantity} ${color} ${size} ${article}