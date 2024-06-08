*** Settings ***
Library  Browser

*** Test Cases ***
A New Browser
    New Browser

A New Visible Browser
    New Browser  browser=firefox  headless=False
