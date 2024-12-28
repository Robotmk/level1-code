*** Settings ***
Documentation     A suite which demonstrates data-driven testing
Test Template     Add Fruit To Basket And Check Total

*** Variables ***
${INITIAL}  5

*** Test Cases ***              (FRUIT_TYPE  QUANTITY  EXPECTED_TOTAL)
Add Apples                      Apples       3          8
Add Bananas                     Bananas      2          7
Add Oranges                     Oranges      4          9
Add No Fruit                    None         0          5

*** Keywords ***
Add Fruit To Basket And Check Total
    [Arguments]    ${fruit}    ${quantity}    ${expected_total}
    ${total}=      Evaluate    ${INITIAL} + ${quantity}
    Should Be Equal As Numbers    ${total}    ${expected_total}