*** Settings ***
Documentation   Complete this RF suite to a DDT approach with a single tets case.  
...    The data rows to iterate over are: 
...    - robot framework
...    - keyword driven testing
...    - positional arguments
...    - scalar variables
...    Use the template keyword `Ask AI`.

*** Test Cases ***              

AI Answer Verification
    # => 


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