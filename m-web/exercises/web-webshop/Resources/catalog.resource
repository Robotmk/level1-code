*** Settings ***
Resource          lib-browser.resource

*** Keywords ***

Add Items To Cart
    [Arguments]    @{items}
    FOR  ${item}    IN    @{items}
        Add Item To Cart    ${item}
    END

Add Item To Cart
    [Arguments]    ${product_name}
    No Operation
    # => 

