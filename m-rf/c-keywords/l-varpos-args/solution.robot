*** Test Cases ***
Combined Example
    [Documentation]  command type, "n" commands, user, timeout
    Run Custom Command    maintenance  cmd1
    Run Custom Command    custom    cmd1    user=bob    timeout=3s
    Run Custom Command    custom    cmd1    cmd2    cmd3    user=alice    timeout=60s

*** Keywords ***
Run Custom Command
    [Arguments]    ${type}    @{commands}    ${user}=admin    ${timeout}=30s
    Log    Running ${type} commands: @{commands} with user ${user} and timeout ${timeout}!
    Log    Running ${type} commands: ${commands} with user ${user} and timeout ${timeout}!