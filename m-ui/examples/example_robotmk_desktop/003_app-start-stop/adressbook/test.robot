# First, let's start and terminate the application. Both are usually done in the 
# Suite Setup/Teardown keywords. From there, we call the specific keywords
# - Open Address Book
# - Close Address Book
# 
# Two variables are defined:
# - APP: Path to the .exe file (escape the backslashes!)
# - EXE: Name of the started process

##### 
# Your tasks: 
# - Set a breakpoint at the marked locatoin at the end of the file
# - try to debug the test; it should open the address book. (Without the breakpoint, you 
#   would not see the window to open!).
# - Press F5 and check if the application terminates as expected. 

*** Settings ***
Documentation     This suite opens the "Free Address Book" and searches for a given user. 
...  The user can be given by variable `SEARCH_NAME` (first + last name).
Library       ImageHorizonLibrary  reference_folder=${CURDIR}\\images   
Resource      common\\ImageHorizon.resource                         

Suite Setup     Suite Initialization    # ⚠️ 
Suite Teardown  Suite Finalization      # ⚠️ 

*** Variables ***
${APP}      C:\\Program Files (x86)\\GAS Softwares\\Free Address Book\\AddressBook.exe  # ⚠️
${EXE}      AdressBook.exe              # ⚠️

*** Test Cases ***
Search User In Database 
    No Operation         # ⚠️ 

*** Keywords ***
Suite Initialization    
    Open Address Book    # ⚠️ 

Suite Finalization     
    Close Address Book   # ⚠️ 

Open Address Book 
    Launch Application    "${APP}"  alias=addressbook   # ⚠️ 

Close Address Book 
    # SET A BREAKPOINT HERE AND DEBUG!
    Terminate Application  alias=addressbook            # ⚠️ 