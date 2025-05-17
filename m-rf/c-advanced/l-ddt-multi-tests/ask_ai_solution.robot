*** Settings ***
Test Template     Ask AI

*** Test Cases ***              

AI Answer Verification 1   robot framework
AI Answer Verification 2   keyword driven testing
AI Answer Verification 3   positional arguments
AI Answer Verification 4   scalar variables


*** Keywords ***

Ask AI 
    [Arguments]    ${question}
    Log    Asking the AI about "${question}"
    ${answer}=    Send Request   AI, please explain ${question}

Send Request 
    [Documentation]  Dummy which simulates the request to an AI service. Sometimes, it can fail.
    [Arguments]    ${question}
    ${randomWait}=    Evaluate    random.randint(1,4)    random
    IF  ${randomWait} == 4  Fail  msg=AI is not responding.
    Log    AI is thinking...
    Sleep    0.8
    RETURN  AI says... foobar. 