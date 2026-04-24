*** Settings ***
Test Tags   sap  # statically set, applied to all tests

*** Variables ***
${CONDITION}   ${True}

*** Test Cases ***
Test One
    [Tags]   wip  # statically set, test level
    No Operation
    Set Tags  customtag  # dynamically set
    IF  ${CONDITION}
        Fail  I failed.  fataltag  veryfatal  # dynamically/conditionally
    END