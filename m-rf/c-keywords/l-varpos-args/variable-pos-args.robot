*** Test Cases ***
Combined Example
    Run Custom Command    cmd1
    Run Custom Command    cmd1    user=bob    timeout=3s
    Run Custom Command    cmd1    cmd2    cmd3    user=alice    timeout=60s

*** Keywords ***
Run Custom Command
    [Arguments]    @{commands}    ${user}=admin    ${timeout}=30s
    Log    Running commands: @{commands} with user ${user} and timeout ${timeout}!
    Log    Running commands: ${commands} with user ${user} and timeout ${timeout}!