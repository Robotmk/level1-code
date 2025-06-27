*** Variables ***
${GREETING}      Hello, Robot Framework!
${USERNAME}      test_user
${PASSWORD}      secret_password

*** Test Cases ***
Test 1 - Login Process
    Login To Application    ${USERNAME}    ${PASSWORD}

Test 2 - Greeting Validation
    ${message}    Set Variable    Hello, Robot Framework!
    Validate Greeting Message    ${message}

*** Keywords ***
# Application keyword
Login To Application
    [Arguments]    ${username}    ${password}
    Log    Attempting to log in with username: ${username} and password: ${password}
    Should Not Be Empty    ${username}
    Should Not Be Empty    ${password}

# Validation keyword
Validate Greeting Message
    [Arguments]    ${message}
    Log    Validating message: ${message}
    Should Be Equal    ${message}    ${GREETING}
