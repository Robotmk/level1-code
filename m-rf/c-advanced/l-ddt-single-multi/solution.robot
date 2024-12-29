*** Settings ***
Documentation     A suite which demonstrates data-driven testing, 
...  with a global test template and one test for each data set. 
Resource          calc.resource
Test Template     Calculate Sum

*** Test Cases ***              
Calculation One  1  1
Calculation Two  1  2
Calculation Three  2  3
Calculation Four  
    [Template]  Calculate Product
    3  4
    5  5