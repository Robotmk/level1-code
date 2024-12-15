*** Settings *** 

Library             Browser

*** Variables ***
${URL}                      https://oxid.robotmk.org
${USERNAME}                 mail@robotmk.org
${PASSWORD}                 crypt:bD22YdO6Om/M63SHz3clvZ4UKpEonuvUh0nO+vHymmFGWjzPveg+dSTFGlVRmSk7ZQQj7anvpBA=

# Login Selectors
${HOME_BARGAIN_HEADLINE}    div#boxwrapper_bargainItems h2
${MENU_BT_ANMELDEN1}        div.service-menu > button
${MENU_F_USERNAME}          input#loginEmail
${MENU_F_PASSWORD}          input#loginPasword
${MENU_BT_ANMELDEN2}        div.service-menu form button
${BANNER_BADLOGIN}          p#errorBadLogin
${MENU_BT_ACCOUNT}          div.service-menu > button


*** Keywords ***
Login
    [Documentation]    Performs a login with the given username/password.
    ...    Depending on the expectfail parameter, an error or success is expected.
    [Arguments]    ${uname}    ${pwd}    ${expectfail}=False    
    Click    ${MENU_BT_ANMELDEN1}
    Fill text    ${MENU_F_USERNAME}    ${uname}
    Fill text    ${MENU_F_PASSWORD}    ${pwd}
    Click    ${MENU_BT_ANMELDEN2}
    IF    ${expectfail} == ${True}  
        Get Element States
        ...    ${BANNER_BADLOGIN} 
        ...    *=
        ...    visible   
        ...    message="Did not receive expected error after login attempt with invalid credentials!"
    ELSE
        Get Text    ${MENU_BT_ACCOUNT}    *=    Mein Konto    message="Login failed!"
    END    


Open Webshop   #    <--HERE--    This new keyword is used before each test starts.
    [Documentation]    Opens the web shop's landing page
    New Browser    browser=${BROWSER}    headless=False
    New Context    viewport=${None}    locale=de-DE
    New Page    ${URL}
    Get text  ${HOME_BARGAIN_HEADLINE}  *=  Angebote der Woche
