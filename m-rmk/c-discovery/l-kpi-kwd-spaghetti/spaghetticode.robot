*** Settings ***
Resource  dummy-keywords.resource

*** Test Cases ***
Check If Ticket Can Be Searched
    Fill Text  username_field    user
    Fill Text  password_field    password123
    Click  login_button
    Wait Until Element Is Visible  ticket_module
    Click  ticket_module
    Fill Text  search_field    12345
    Click  search_button
    Wait Until Element Is Visible  ticket_results
    Should Contain  12345  12345