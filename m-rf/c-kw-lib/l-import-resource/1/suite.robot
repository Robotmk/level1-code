*** Settings ***
Resource  res_A.resource



*** Test Cases ***
Test 1
    Log to console   ${VAR_A}
    Log to console   ${VAR_B}