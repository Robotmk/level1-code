*** Keywords ***
Calculate Sum
    [Arguments]    ${no1}    ${no2} 
    ${total}=      Evaluate    ${no1} + ${no2}
    RETURN    ${total}

Calculate Product1
    [Arguments]    ${no1}    ${no2} 
    ${total}=      Evaluate    ${no1} * ${no2}
    RETURN    ${total}