
*** Test Cases ***
Test One
    Log  Test One was executed.
    VAR  ${SKIP_TWO}  skip  scope=suite
    #VAR  ${SKIP_THREE}  skip  scope=suite
    VAR  ${SKIP_FOUR}  skip  scope=suite

Test two
    [Tags]  robot:${SKIP_TWO}
    Log  Test Two was executed.

Test three
    [Tags]  robot:${SKIP_THREE}
    Log  Test Two was executed.

Test four
    [Tags]  robot:${SKIP_FOUR}
    Log  Test Two was executed.
