*** Settings ***
Resource  ../../Resources/BrowserCommon.resource
Suite Setup  Browser Initialization  ${URL}

*** Variables ***
${URL}  https://sampleapp.tricentis.com/101/app.php

*** Test Cases ***

Enter Vehicle Data
    Select Options By  \#make  value  BMW
    Select Options By  \#model  value  Motorcycle
    Fill Text  \#cylindercapacity  1200
    Fill Text  \#engineperformance  88
    Fill Text  \#dateofmanufacture  05/02/2006
    Select Options By  \#numberofseats  value  2
    # this is not a regular radiogroup, but a "faked"!
    # -> use relative XPath to select "No" from this group
    Click  //label[text()='Right Hand Drive']/following-sibling::p/label[text()='No']
    Select Options By  \#numberofseatsmotorcycle  value  2
    Select Options By  \#fuel  value  Petrol
