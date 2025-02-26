*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://sampleapp.tricentis.com/101/app.php

*** Test Cases ***

Enter Vehicle Data
    No Operation
    # Select these options: 
    # - make: BMW
    # - model: Motorcycle
    # - number of seats: 2