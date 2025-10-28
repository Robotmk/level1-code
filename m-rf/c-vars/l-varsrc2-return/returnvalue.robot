*** Settings ***
Documentation    This suite demonstrates how to return values from a keyword
Library    OperatingSystem

*** Variables ***
${SENTENCE}    Sapien risus aliquet torquent, vivamus feugiat curae est.
${EXPECTED_LENGTH}    57

*** Test Cases ***
Returning A Scalar
    # length of ${SENTENCE} should be 57 (line 7)
    # Use: https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Should%20Be%20Equal%20As%20Numbers
    # =>
    No Operation
    
Returning A List
    # There should be a file called returnvalue.robot 
    # Use: https://robotframework.org/robotframework/latest/libraries/OperatingSystem.html#List%20Directory
    # Use: https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Should%20Contain
    # =>
    No Operation

Returning a Dict Example
    # Log the PATH environment variable
    # Use: https://robotframework.org/robotframework/latest/libraries/OperatingSystem.html#Get%20Environment%20Variables
    # =>
    No Operation

Multiple Return Example
    # Split the path server/logs/server.log into folder and file
    # Use: https://robotframework.org/robotframework/latest/libraries/OperatingSystem.html#Split%20Path
    # Use: https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Should%20Be%20Equal
    # Path must be server/logs and file server.log
    # =>
    No Operation