*** Test Cases ***
Test A
    Log  Test One was executed.
    VAR  ${SKIP_FLAG}  ${False}  scope=suite

Test B
    Skip If  ${SKIP_FLAG}
    Log  Test Two was executed.