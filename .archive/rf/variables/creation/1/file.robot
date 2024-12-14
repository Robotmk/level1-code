*** Variables ***
${SALUTATION}   Hello
${NAME}         Robotmk
${GREET}        ${SALUTATION}, ${NAME}!





*** Test Cases ***

A Test With Scalar Variables
    Log To Console   ${SALUTATION}, ${NAME}!    
    Log To Console   ${GREET}

A Test With List Variables
    Log    @{MONTIORING_SYSTEMS}
    Log    @{MORE_MONTIORING_SYSTEMS}

A Test With A Dict Variable
    Log To Console    &{USER}

