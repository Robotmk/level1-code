*** Settings ***
Resource  dummy-keywords.resource

*** Test Cases ***
Check If Ticket Can Be Searched
    Login To Application
    Search Ticket    12345


*** Keywords ***
Login To Application
    Fill Text  username_field    user
    Fill Text  password_field    password123
    Click  login_button
    Wait Until Element Is Visible  ticket_module

Search Ticket
    [Arguments]    ${ticket_id}
    Click  ticket_module
    Fill Text  search_field    ${ticket_id}
    Click  search_button
    Wait Until Element Is Visible  ticket_results
    Should Contain  ${ticket_results}  ${ticket_id}
