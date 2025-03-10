*** Settings ***
Documentation     A suite which demonstrates data-driven testing, 
...  with a SINGLE test for all data sets. 
Resource          calc.resource
Test Template     Calculate Sum

*** Test Cases ***              
Calculations  
    1  1
    1  2
    2  3