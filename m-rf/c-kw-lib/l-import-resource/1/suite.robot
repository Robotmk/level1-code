*** Settings ***
Resource  res_A.resource

*** Variables ***
# uncomment this for task 2: 
${VAR_A}  Var_A from suite!

*** Test Cases ***
Test 1
    Log   ${VAR_A}
    Log   ${VAR_B}