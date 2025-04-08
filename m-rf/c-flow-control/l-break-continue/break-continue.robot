*** Settings ***
Library    Collections

*** Variables ***   
@{NUMBERS}    -3    5    -1    7    0    -8    9

*** Test Cases ***
Find Target Value
    [Documentation]  This test case logs when the target number is found in the numbers list.
    VAR  ${target}   7
    # FOR ...
    #     IF   ...
    #         Log    Target number found: ${num}
    #         ...
    #     END
    # END

Find Positive Numbers
    [Documentation]  This test case logs only the POSITIVE numbers from the list.
    # Use: 
    # Append To List   ${list}   ${item_to_add}
    VAR   @{positive_numbers}
    FOR  ...
        IF  ...
    END
    Log   Positive numbers: @{positive_numbers}