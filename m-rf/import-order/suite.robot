*** Settings ***
Resource  res_A.resource
Resource  res_B.resource

*** Variables ***
${VAR_A}   var-suite-first
${VAR_A}   var-suite-second


*** Test Cases ***
Test 1
    Log to console   ${VAR_A}