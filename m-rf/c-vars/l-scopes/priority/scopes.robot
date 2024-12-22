*** Settings ***
Resource  ./${LOADRES}.resource

*** Variables ***
${LOADRES}         Cherries
${MEAT}            Chicken
${MEAT}            Crocodile

*** Test Cases ***

Show The Basket 1
    Log To Console  The \${BASKET} contains: ${BASKET_CONTENT}
    Log To Console  Variable \${MEAT}: ${MEAT}
    Log To Console  Variable \${COLOR}: ${COLOR}
    VAR  ${BASKET_CONTENT}  Smarties  scope=suite
    VAR  ${MEAT}    Giraffe
    VAR  ${COLOR}   Pink  scope=test


Show The Basket 2
    Log To Console  The \${BASKET} contains: ${BASKET_CONTENT}
    Log To Console  Variable \${MEAT}: ${MEAT}
    Log To Console  Variable \${COLOR}: ${COLOR}

