*** Settings ***
Documentation      Examples for assertion keywords. 
...  For more, see https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Should%20Be%20Empty

*** Variables ***
${NAME}  Robot

*** Test Cases ***
Keywords With Should
    Should Be Equal As Integers  ${1}  ${1}    # Comparing two numbers
    Should Be Equal As Numbers  ${1.1}  ${1.1}    # Comparing two float numbers
    Should Be Equal As Strings  ${NAME}  Robot    # Comparing two strings
    Should Be True  "${NAME}" == "Robot"   # Check if NAME is equal to 'Robot'
    Should Match  Lorem Ipsum Dolor Sit Amet    *Ipsum Dolor*    # Check if the substring matches a pattern
    Should Contain  Lorem Ipsum Dolor Sit Amet    Ipsum Dolor    # Same, with contain