*** Settings ***
Documentation      This suite demonstrates the use of primitive data types in Robot Framework.

*** Variables ***
${STRING}            This is a string
${STILL_STRING}      8270      # sequence of characters "8" "2" "7" "0"
${INTEGER}           ${42}     # used as a "integer"
${FLOAT}             ${3.14}   # "float" recognized (decimal point!)
${BOOLEAN}           ${True}   # True/true/False/false are recognized as boolean
${NOTHING}           ${NONE}   # None/none are recognized as "None"
${EMPTY_STRING}                
${ANSWER}            The answer is ${INTEGER}    # This will be 'The answer is 42'

*** Test Cases ***
Test 1
    Log To Console   ${STRING}
    Log To Console    ${STILL_STRING}
    Log To Console    ${INTEGER}
    Log To Console    ${FLOAT}
    Log To Console    ${BOOLEAN}
    Log To Console    ${NOTHING}
    Log To Console    ${EMPTY_STRING}
    Log To Console    ${ANSWER}