*** Settings ***
Library    MyLib.py
Documentation    This is a test suite for the String library.

*** Variables ***
${MYSTRING}   Litora praesent curae 
...    tempus libero penatibus urna 
...    at nunc taciti
...    separator=\n

*** Test Cases *** 
Test One
    ${line}=  Get Line  ${MYSTRING}  1
    Log To Console  ${line}