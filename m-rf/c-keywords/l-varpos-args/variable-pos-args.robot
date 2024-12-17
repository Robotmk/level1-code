*** Test Cases ***
Combined Example
    [Documentation]  command type, "n" commands, user, timeout
    Run Custom Command    maintenance  cmd1
    Run Custom Command    custom    cmd1    user=bob    timeout=3s
    #3
    Run Custom Command    custom    cmd1    cmd2    cmd3    user=alice    timeout=60s

*** Keywords ***
Run Custom Command
    #[Arguments]    ???
    # Expected Log message (example: keyword call #3)
    # Running custom commands: ['cmd1', 'cmd2', 'cmd3'] with user alice and timeout 60s!
    Log    Running commands: ... 