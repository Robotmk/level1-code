*** Test Cases ***
Expl IF Statement
    VAR  ${value}  10
    IF    ${value} > 5
        Log    Value is greater than 5
    END

Expl IF ELSE Statement
    VAR  ${value}  10
    IF    ${value} < 5
        Log    Value is greater than 5
    ELSE
        Log    Value is less than 5
    END

Expl IF ELSE IF ELSE Statement
    VAR  ${value}  5
    IF    ${value} > 5
        Log    Value is greater than 5
    ELSE IF    ${value} == 5
        Log    Value is equal to 5
    ELSE
        Log    Value is less than 5
    END

Expl Inline IF Statement
    VAR  ${value}  15
    IF    ${value} > 5    Log    Value is greater than 5

Expl Var Assignments with Inline IF Statements
    ${var} =    IF    $condition    Keyword    argument    ELSE    Another Keyword
    ${user}    ${password} =    IF    $production    Get Production Auth    ELSE    Get Testing Auth