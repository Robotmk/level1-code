*** Variables ***
${GERMAN_LEGAL_AGE}  18
${GOUDA_YOUNG_WEEKS}  4
${GOUDA_MEDIUM_AGED_WEEKS}  18
${GOUDA_OLD_WEEKS}  52

*** Test Cases ***
IF-Tests
    # Ex.: User is not of legal age!
    Check Legal Age    17
    Check Legal Age    21

    # Ex.: Gouda is medium aged
    Determine Gouda Type    3
    Determine Gouda Type    15
    Determine Gouda Type    41
    Determine Gouda Type    120

*** Keywords ***
Check Legal Age
    [Documentation]  Writes to the log file whether the user is of legal age.
    No Operation

Determine Gouda Type
    [Documentation]  Writes to the log file the type of Gouda based on the age in weeks.
    No Operation