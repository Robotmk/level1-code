*** Settings ***
Library    Collections

*** Variables ***   
@{numbers}    -3    5    -1    7    0    -8    9

*** Test Cases ***
Find Target Value
    VAR  ${target}   7
    FOR    ${num}    IN    @{numbers}
        Log    Checking number: ${num}
        IF    ${num} == ${target}
            Log    Target number found: ${num}
            No Operation
        END
    END
    Log    Search completed

Skip Negative Numbers
    Log    Only processing positive numbers...
    VAR   @{positive_numbers}
    FOR    ${num}    IN    @{numbers}
        Log    Checking number: ${num}
        IF  ${num} <= 0   No Operation   ELSE  Append To List   ${positive_numbers}   ${num}
    END
    Log   Positive numbers: @{positive_numbers}