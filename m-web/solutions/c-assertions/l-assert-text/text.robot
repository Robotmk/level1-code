*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Init
Test Setup  Session Init  ${URL}


*** Variables ***
${URL}  https://ginandjuice.shop/
${SECOND_PRODUCT}  (//section[@class='container-list-tiles']/a[starts-with(@href, '/catalog/product')])[2]

*** Test Cases ***

Gin Book Is Second Product On Start Page
    Get Element States  ${SECOND_PRODUCT}  contains  visible
    Get text   ${SECOND_PRODUCT}  matches  (?i)create your own cocktail

Copyright Verification
    Get text   .footer-copyright  ==  © 2023 PortSwigger Ltd.



    

