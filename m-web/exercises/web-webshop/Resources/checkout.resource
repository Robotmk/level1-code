*** Settings ***
Resource          lib-browser.resource

*** Keywords ***
Checkout
    Click          data-test=proceed-1
    Click          data-test=proceed-2
    Fill Billing Address
    Execute Payment
    
Fill Billing Address
    No Operation
    # =>

Execute Payment 
    [Arguments]  
    No Operation
    # =>
