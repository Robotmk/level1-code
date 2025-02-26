*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://ginandjuice.shop/catalog


*** Test Cases ***

Test Product Category Content
    #  Write a test which checks all categories with DDT
    No Operation

*** Keywords ***

