*** Variables ***
${P_STRING}        Hello, World!
${P_STRNUMBER}     123
${P_INT}           ${789}
@{L_FRUITS}        Apple    Banana    Cherry
&{D_USER}          name=robotmk    password=secret

*** Test Cases ***
Scalar Access
    Log    ${P_STRING}
    Log    ${P_STRNUMBER}
    Log    ${P_INT}
    Log    ${L_FRUITS}
    Log    ${D_USER}

List Access
    Log Many  @{L_FRUITS}
    Log Many  &{D_USER}

Dict Access
    Login  &{D_USER}

*** Keywords ***
Login
    [Arguments]    ${name}    ${password}
    Log    ${name}
    Log    ${password}