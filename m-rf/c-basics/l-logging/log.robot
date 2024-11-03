*** Settings ***
Documentation      This suite shows the different use cases of logging. 

*** Variables ***
${URL}            https://example.com
${USERNAME}       testuser
${PASSWORD}       password123

*** Test Cases ***
Log Level Demonstration
    Log    Starting Log Level Demonstration test    level=INFO
    Log To Console    Executing test case... (visible in console only)
    
    Log    Attempting to open browser and navigate to ${URL}    level=DEBUG
    Log To Console    Debugging information: Navigating to ${URL}

    Log    TRACE: Preparing to input user credentials.    level=TRACE
    Log    Username: ${USERNAME}    level=TRACE
    Log    Password: ${PASSWORD}    level=TRACE
    
    # Simulating a warning condition
    Log    Warning: Page load time exceeded expected duration    level=WARN
    
    # Simulate failure if login is unsuccessful
    ${login_successful}=    Set Variable    False
    Run Keyword If    not ${login_successful}    Fail    Login failed: Invalid credentials or timeout

    # Final log message to indicate the end of the test
    Log    Test completed. Cleaning up resources...    level=INFO
    Log To Console    End of test case execution.