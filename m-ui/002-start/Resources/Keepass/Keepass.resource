*** Settings ***
Library  Process
Resource  ../Common/IHL_keywords.resource

*** Variables ***
# Path separators are platform dependent; Shift+rightlick on Keepass.exe and select 
# "Copy as path" to get the correct path. 
# Instead of a hardcoded user profile path, you can use %USERPROFILE% 
${KEEPASS_EXE}  %{USERPROFILE}/Downloads/KeePass-2.57.1/KeePass.exe

*** Keywords ***
Open Keepass
    # Start the Keepass process (non-blocking) and save the handle
    ${handle}=  Start Process    ${KEEPASS_EXE}
    # Save the handle in another variable with SUITE scope so that it 
    # can be accessed later in the "Close Keepass" keyword
    VAR  ${KEEPASS_HANDLE}  ${handle}  scope=suite

Close Keepass
    No Operation
