*** Settings ***
Documentation    This suite demonstrates how to return values from a keyword
Library    OperatingSystem

*** Variables ***
${SENTENCE}    Sapien risus aliquet torquent, vivamus feugiat curae est.
${EXPECTED_LENGTH}    57

*** Test Cases ***
Scalar From Keyword
    # Goal: Check that length of ${SENTENCE} is ${EXPECTED_LENGTH}
    # Get Length: https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Get%20Length
    # Should be Equal As Numbers: https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Should%20Be%20Equal%20As%20Numbers
    No Operation
    
List From Keyword
    # Goal: Check that there is a file called returnvalue.robot in the current directory
    # List Directory: https://robotframework.org/robotframework/latest/libraries/OperatingSystem.html#List%20Directory
    # Should Contain: https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Should%20Contain
    No Operation

List From Keyword 2
    # Goal: Split the path server/logs/server.log into folder and file and check that Path is 
    # server/logs and file server.log
    # Use: https://robotframework.org/robotframework/latest/libraries/OperatingSystem.html#Split%20Path
    # Use: https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Should%20Be%20Equal
    No Operation

Dict From Keyword
    # Goal: Get env vars, Log the PATH environment variable
    # Get Environment Variables: https://robotframework.org/robotframework/latest/libraries/OperatingSystem.html#Get%20Environment%20Variables
    No Operation
