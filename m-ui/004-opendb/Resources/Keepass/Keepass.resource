*** Settings ***
Library  Process
Resource  ../Common/IHL_keywords.resource

*** Variables ***
${KEEPASS_EXE}  %{USERPROFILE}/bin/KeePass.exe

*** Keywords ***
Open Keepass
    ${handle}=  Start Process    ${KEEPASS_EXE}
    VAR  ${KEEPASS_HANDLE}  ${handle}  scope=suite

Close Keepass
    Terminate Process  ${KEEPASS_HANDLE}  kill=True

Open Database
    [Documentation]  Opens a Keepass database file and waits for the 
    ...  main window to show the robotmk database.
    # Positional mandatory arguments (no default values) 
    [Arguments]  ${db}  ${pw}
    # As soon as the  menu bar is visible...
    Wait For    menubar    timeout=10
    # ... continue with opening the database
    Press Combination    Key.Ctrl  Key.o
    # Set the cursor to the filename field, identified by 
    # the label on the left side of the field
    Wait For And Click To The Right Of    
    ...    open_dialog_filename    
    ...    offset=50
    # Type the database file path and confirm with Enter
    Type    ${db}    Key.Enter
    # Set the cursor to the password field, identified by
    # the label on the left side of the field
    Wait For And Click To The Right Of    
    ...    password_dialog_masterpassword    
    ...    offset=50
    # Type the password and confirm with Enter
    Type    ${pw}    Key.Enter
    # Wait for the main window to show the database
    Wait For  main_robotmkdb
