*** Settings ***
Documentation    
Resource  ./${CMDVAR}.resource

*** Variables ***
${BASKET_CONTENT}  Bananas (from suite vars)

*** Test Cases ***

Show The Basket
    Log To Console  The \${BASKET} contains: ${BASKET_CONTENT}
    Log To Console  Variable \${MEAT}: ${MEAT}
    Log To Console  Variable \${CMDVAR}: ${CMDVAR} (not overridden by Apple-Res-2.resource)


# TODO zeige das Suite-scope nicht rekursiv ist.