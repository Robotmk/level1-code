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
    # Forcefully closing Keepass using the handle
    Terminate Process  ${KEEPASS_HANDLE}  kill=True
