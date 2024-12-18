*** Test Cases ***
Combined Example
    Run Custom Command    ping    arg1    arg2   
    ...    host=server121   
    ...    timeout=60s   
    ...    asuser=alice    
    ...    shell=cmd.exe

*** Keywords ***
Run Custom Command
    [Arguments]    ${command}   @{cmdargs}    ${host}=localhost    
    ...    ${timeout}=60s   &{kwargs}
    ${argstr}=  Catenate   @{cmdargs}
    Log To Console  Running command: ${kwargs}[shell] -c ${command} 
    ...    ${argstr} --timeout ${timeout} --user ${kwargs}[asuser] ${host}