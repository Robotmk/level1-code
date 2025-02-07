*** Settings ***
Library  Process
Resource  ../Common/IHL_keywords.resource

*** Variables ***
${KEEPASS_EXE}  %{USERPROFILE}/Downloads/KeePass-2.57.1/KeePass.exe

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
    [Arguments]  ${entryname}  ${entryimg}
    # Open the Search dialogue
    Press Combination    Key.Ctrl  f
    # Place the cursor into the search field
    Wait For And Click To The Right Of  find_label  100
    # enter the search string and confirm with enter
    Type    ${entryname}   Key.enter
    # Expect the result somewhere on the screen
    Wait for   ${entryimg}
