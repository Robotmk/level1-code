*** Keywords ***

Log The Resource Path Variables
    Log To Console   In the Resource file is {CURDIR}: ${CURDIR}.
    # Calling a keyword from the suite file in a resource file!
    Log Builtin Path Variables