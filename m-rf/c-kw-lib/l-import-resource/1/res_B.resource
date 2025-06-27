*** Variables ***
${VAR_B}  Hello, this is Var B from res_B!

*** Keywords ***
My B-Keyword
    [Documentation]  This is a keyword from res_B.resource
    Log  ${VAR_A}
    Log  ${VAR_B}