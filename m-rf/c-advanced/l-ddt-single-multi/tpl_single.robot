*** Settings ***
Documentation     A suite which demonstrates data-driven testing, 
...  with a test scoped template and a SINGLE test for all data sets. 
Resource          calc.resource
Test Template     Calculate Sum

*** Test Cases ***              
Calculate Sums  
    1  1
    1  2
    2  3
    3  4
    5  5
