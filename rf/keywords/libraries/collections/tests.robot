*** Settings ***
Library    Collections

*** Test Cases ***
Example with Collections
    ${list}    Create List    Apple    Banana    Cherry
    List Should Contain Item    ${list}    Banana