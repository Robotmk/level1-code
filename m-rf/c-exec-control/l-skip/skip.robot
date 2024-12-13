*** Variables ***
${SKIP_FLAG}    skip

*** Test Cases ***
Test One
    Log  Test One was executed.
    VAR  ${SKIP_FLAG}  skip  scope=suite

Test two
    [Tags]  robot:${SKIP_FLAG}
    Log  Test Two was executed.
