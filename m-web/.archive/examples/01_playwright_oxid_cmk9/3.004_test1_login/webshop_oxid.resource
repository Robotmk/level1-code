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