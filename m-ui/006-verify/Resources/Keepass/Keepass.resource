*** Settings ***
Library  Process
Resource  ../Common/IHL_keywords.resource

*** Variables ***
${KEEPASS_EXE}  %{USERPROFILE}/bin/keepass/KeePass.exe

*** Keywords ***
Open Keepass
    ${handle}=  Start Process    ${KEEPASS_EXE}
    VAR  ${KEEPASS_HANDLE}  ${handle}  scope=suite

Close Keepass
    Terminate Process  ${KEEPASS_HANDLE}  kill=True

Open Database
    [Documentation]  Opens a Keepass database file and waits for the 
    ...  main window to show the robotmk database. 
    [Arguments]  ${db}  ${pw}
    Wait For    menubar    timeout=10
    Press Combination    Key.Ctrl  o
    Wait For And Click To The Right Of    
    ...    open_dialog_filename    
    ...    offset=50
    Type    ${db}    Key.Enter
    Wait For And Click To The Right Of    
    ...    password_dialog_masterpassword    
    ...    offset=50
    Type    ${pw}    Key.Enter
    Wait For  main_robotmkdb


Search Entry
    [Documentation]  Searches for the entry given by argument and verifies
    ...  the result.  
    [Arguments]  ${entryname}
    Press Combination    Key.Ctrl  f
    Wait For And Click To The Right Of  find_label  100
    Type    ${entryname}   Key.enter
    Wait for   ${entryname}

Verify Password
    [Documentation]  Reads the Password of a given entry and compares it 
    ...  against the expected value. 
    [Arguments]  ${img}  ${exp_pass}
    # The entry should be selected already; just to be sure...
    Wait For And Click  ${img}
    # Copy the entry password into the clipboard
    Press Combination   Key.Ctrl  c
    # Read the password from clipboard into a local variable
    ${pass}=  Get Clipboard Content
    # Compare both strings
    Should Be Equal As Strings  ${pass}  ${exp_pass}
    ...  msg=String from DB does not match expected string!
