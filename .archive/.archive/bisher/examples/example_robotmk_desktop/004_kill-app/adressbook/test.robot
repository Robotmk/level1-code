# We cannot rely on the fact the the termination works. It is better - and good 
# practice - to create clear conditions at the beginning and try to KILL first 
# all instances which are probably still running.
# The Process library allows to run/start arbitrary commands. We use it here 
# to call "taskkill" in order to kill zombie instances of the application. 

##### 
# Your tasks: 
# - Open the Adress book by hand
# - Start the test; it should close the app process. 

*** Settings ***
Documentation     This suite opens the "Free Address Book" and searches for a given user. 
...  The user can be given by variable `SEARCH_NAME` (first + last name).
Library       ImageHorizonLibrary  reference_folder=${CURDIR}\\images   
Library       Process     # ⚠️ 
Resource      common\\ImageHorizon.resource                         

Suite Setup     Suite Initialization    
Suite Teardown  Suite Finalization      

*** Variables ***
${APP}      C:\\Program Files (x86)\\GAS Softwares\\Free Address Book\\AddressBook.exe  
${EXE}      AdressBook.exe              

*** Test Cases ***
Search User In Database 
    No Operation         

*** Keywords ***

Kill Addressbook
    Run Process  cmd.exe /c taskkill /F /IM AddressBook.exe  shell=True   # ⚠️ 

Suite Initialization    
    Open Address Book    

Suite Finalization     
    Close Address Book   

Open Address Book 
    Kill Addressbook    # ⚠️ 
    Launch Application    "${APP}"  alias=addressbook   

Close Address Book 
    Terminate Application  alias=addressbook      

