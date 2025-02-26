*** Settings ***
Library     Browser


*** Test Cases ***
Test Foundation Headlines
    New Browser    browser=firefox    headless=False
    New Context    locale=en-US
    New Page    url=https://robotframework.org
    Click  div.navbar >> text=Foundation
    Get Text  (//h2)[1]  ==  BENEFITS AND COST
    Get Text  (//h2)[2]  ==  HOW TO JOIN
    Get Text  (//h2)[3]  ==  WHAT WE DO
    # the same case-insensitive - regex approach 
    Get Text  (//h2)[1]  matches  BENEFITS.*
    Get Text  (//h2)[2]  matches  ^.*JOIN
    Get Text  (//h2)[3]  matches  .*WHAT WE DO.*
