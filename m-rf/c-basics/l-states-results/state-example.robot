*** Test Cases ***
Test 1 - Should Pass
    Log  I am ok!   

Test 2 - Should Fail
    Fail  Something strange happened!
    Log  I am fine. 

Test 3 - Gets skipped
    Log  I am ok!
    Skip  msg=Something weird happened. Better skip this test completely.
    Log  I am not executed anymore...
    Fail  