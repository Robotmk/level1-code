*** Settings ***
Documentation     A suite which demonstrates data-driven testing, 
...  with a SINGLE test for all data sets. 
Resource          calc.resource
Test Template     Calculate Sum

*** Test Cases ***              
Calculate Sums  
    1  1
    1  2
    2  3