*** Settings ***
Resource  res_B.resource

*** Variables ***
${VAR_A}  Hello, this is Var A from res_A!

*** Keywords ***

My A-Keyword
    [Documentation]  This is a keyword from res_A.resource
    Log  ${VAR_A}
    Log  ${VAR_B}