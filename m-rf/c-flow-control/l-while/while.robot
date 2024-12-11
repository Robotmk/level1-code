*** Settings ***
Documentation  Demonstrate the usage of the WHILE loop.

*** Variables ***
@{fruits}     apple  banana  cherry

*** Test Cases ***

While Loop with Counter
    VAR  ${counter}  1
    WHILE    ${counter} <= 5
        Log    Current counter value: ${counter}
        ${counter}=    Evaluate    ${counter} + 1
    END

While Loop to Process List
    VAR  ${counter}  1
    WHILE    ${counter} <= len(@{fruits})
        ${index}=    Evaluate    ${counter} - 1
        Log to console     Processing item: ${fruits}[${index}]
        ${counter}=    Evaluate    ${counter} + 1
    END