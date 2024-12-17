*** Settings ***
Library    Collections

*** Variables ***   
@{NUMBERS}    -3    5    -1    7    0    -8    9

*** Test Cases ***
Find Target Value
    [Documentation]  This test case finds the target number from the list.
    VAR  ${target}   7
    FOR    ${num}    IN    @{NUMBERS}
        Log    Checking number: ${num}
        IF    ${num} == ${target}
            Log    Target number found: ${num}
            BREAK
        END
    END
    Log    Search completed

Skip Negative Numbers
    [Documentation]  This test case returns only positive numbers form the list.ssing positive numbers...
    VAR   @{positive_numbers}
    FOR    ${num}    IN    @{NUMBERS}
        Log    Checking number: ${num}
        IF  ${num} <= 0   CONTINUE  ELSE  Append To List   ${positive_numbers}   ${num}
    END
    Log   Positive numbers: @{positive_numbers}