*** Settings ***
Documentation     A suite which demonstrates data-driven testing, 
...  with a global test template and one test for each data set. 
Test Template     Ask AI

*** Test Cases ***              

AI Answer Verification
    [Documentation]  Named Test with multiple data rows
    robot framework
    keyword driven testing
    positional arguments
    scalar variables


*** Keywords ***

Ask AI 
    [Arguments]    ${question}
    Log    Asking the AI about "${question}"
    ${answer}=    Send Request   AI, please explain ${question}

Send Request 
    [Documentation]  This is a dummy keyword to simulate sending a request to an AI service.
    [Arguments]    ${question}
    ${randomWait}=    Evaluate    random.randint(1,4)    random
    IF  ${randomWait} == 4  Fail  msg=AI is not responding.
    Log    AI is thinking...
    Sleep    0.8
    RETURN  AI says... foobar. 