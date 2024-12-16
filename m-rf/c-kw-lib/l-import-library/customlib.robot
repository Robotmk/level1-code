*** Settings ***
Library  CustomLibrary.py

*** Test Cases ***

Test Hello 
    Say Hello  Robots

Test Addition
    ${result}=  Add Numbers  44  11
    Log  ${result}