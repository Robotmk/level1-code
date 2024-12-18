*** Variables ***
${GERMAN_LEGAL_AGE}  18
${GOUDA_YOUNG_WEEKS}  4
${GOUDA_MEDIUM_AGED_WEEKS}  18
${GOUDA_OLD_WEEKS}  52

*** Test Cases ***
IF-Tests 
    Check Legal Age    17
    Check Legal Age    21
    Determine Gouda Type    3
    Determine Gouda Type    15
    Determine Gouda Type    41
    Determine Gouda Type    120

*** Keywords ***

Check Legal Age
    [Documentation]  Writes to the log file whether the user is of legal age.
    [Arguments]    ${age}
    IF    ${age} < ${GERMAN_LEGAL_AGE}
        Log    User is not of legal age!
    ELSE
        Log    User is of legal age!
    END

Determine Gouda Type
    [Documentation]  Writes to the log file the type of Gouda based on the age in weeks.
    [Arguments]    ${age}
    IF    ${age} < ${GOUDA_YOUNG_WEEKS}
        Log    Gouda is young
    ELSE IF    ${age} < ${GOUDA_MEDIUM_AGED_WEEKS}
        Log    Gouda is medium aged
    ELSE IF    ${age} < ${GOUDA_OLD_WEEKS}
        Log    Gouda is old
    ELSE
        Log    Gouda is very old 🤮
    END