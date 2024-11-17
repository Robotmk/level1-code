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
    No Operation