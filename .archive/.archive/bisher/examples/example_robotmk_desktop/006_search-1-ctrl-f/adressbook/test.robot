# Now that pre- and post-hooks are working, we can start with the test. 
# Before "No Operation" (leave this to have a line to set a breakpoint), 
# we defined the keyword "Seach For Entry."
# First, we access the search field with the shortcut Ctrl+f, executed by the
# keyword "Press Combination". 
# (https://eficode.github.io/robotframework-imagehorizonlibrary/doc/ImageHorizonLibrary.html#Press%20Combination)
#
# After that, the keyword "Type" enters the name to search. 
# 
# But, - argh! The application does not support to search by Full Name (as given with the 
# variable "SEARCH_NAME"). Instead, we split this variable into a list @{name} during 
# the Suite Initialization keyword. 
# The Keyword "Split String" is part of the "String" Library; it must be imported, 
# but not be installed separately (it is part of the default libraries coming with
# Robot Framework). 
# 
# "Set Suite Variable" is used to define these two variables on the Suite scope (="global" variable)
# (http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#variable-scopes)
# Tip: The convention is to write global/Suite vars in UPPERCASE.
# You see here how a list variable gets accessed: 
# - ${name}[0] = first list item
# - ${name}[1] = second list item
# 
# Now, that ${FIRST_NAME} is defined in the Suite Setup as a global var, we can access it 
# in the keyword "Search For Entry". 


##### 
# Your tasks: 
# - Set a breakpoint and check if Robot enters "Lisa" into the search field. 

*** Settings ***
Documentation     This suite opens the "Free Address Book" and searches for a given user. 
...  The user can be given by variable `SEARCH_NAME` (first + last name).
Library       ImageHorizonLibrary  reference_folder=${CURDIR}\\images   
Library       Process 
Library       String      # ⚠️ 
Library       common\\WindowsUtils.py    
Resource      common\\ImageHorizon.resource                         

Suite Setup     Suite Initialization    
Suite Teardown  Suite Finalization      

*** Variables ***
${APP}      C:\\Program Files (x86)\\GAS Softwares\\Free Address Book\\AddressBook.exe  
${EXE}      AdressBook.exe        
${SEARCH_NAME}  Lisa Simpson       # ⚠️   

*** Test Cases ***
Search User In Database 
    Search For Entry   # ⚠️  
    # Set a breakpoint here   
    No Operation

*** Keywords ***
Search For Entry 
    Press Combination  Key.CTRL  f       # ⚠️ 
    Type  ${FIRST_NAME}      # ⚠️ 

Kill Addressbook
    Run Process  cmd.exe /c taskkill /F /IM AddressBook.exe  shell=True   

Suite Initialization 
    @{name}=  Split String  ${search_name}              # ⚠️ 
    Set Suite Variable    ${FIRST_NAME}  ${name}[0]     # ⚠️ 
    Set Suite Variable    ${LAST_NAME}  ${name}[1]      # ⚠️ 
    Open Address Book    

Suite Finalization     
    Close Address Book   

Open Address Book 
    Kill Addressbook    
    Launch Application    "${APP}"  alias=addressbook   
    Wait For Window And Activate    .*Free Address Book  maximize=True    
    Wait For          ab_logo          

Close Address Book 
    Terminate Application  alias=addressbook      

