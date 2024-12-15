# Lastly, we want to check if the contact detail page is open and contains the expected
# data. 
# A simple "Wait For" would work here. 
# But in case of a failure we want to throw a custom message. 
# That's why we call "Wait For" with "Run Keyword And Return Status". This doesn't throw
# an exception in any case, but only returns a boolean value which we save into ${found}.
# 
# The IF statement evaluates if nothgin was found; if so, it calls "Fail" with a custom message. 

# The screenshot of the contact details is named Lisa_Simpson_details. 
# This file name gets searched dynamically by the expression ${FIRST_NAME}_${LAST_NAME}_details.

##### 
# Your tasks: 
# - Check if the test is running properly. 

*** Settings ***
Documentation     This suite opens the "Free Address Book" and searches for a given user. 
...  The user can be given by variable `SEARCH_NAME` (first + last name).
Library       ImageHorizonLibrary  reference_folder=${CURDIR}\\images   
Library       Process 
Library       String       
Library       common\\WindowsUtils.py    
Resource      common\\ImageHorizon.resource                         

Suite Setup     Suite Initialization    
Suite Teardown  Suite Finalization      

*** Variables ***
${APP}      C:\\Program Files (x86)\\GAS Softwares\\Free Address Book\\AddressBook.exe  
${EXE}      AdressBook.exe        
${SEARCH_NAME}  Lisa Simpson          

*** Test Cases ***
Search User In Database 
    Search For Entry     
    # Set a breakpoint here   
    No Operation

*** Keywords ***
Search For Entry 
    Press Combination  Key.CTRL  f     
    Type  ${FIRST_NAME}       
    Sleep  1   
    Wait For And Click  ${LAST_NAME}               
    # Set a breakpoint here 
    Wait For And Double Click    ${FIRST_NAME}_marked
    ${found}=  Run Keyword And Return Status                 # ⚠️   
    ...  Wait For  ${FIRST_NAME}_${LAST_NAME}_details        # ⚠️           
    IF  not ${found}                                         # ⚠️   
        Fail  msg=No entry found for ${SEARCH_NAME}!         # ⚠️   
    END                                                      # ⚠️   

Kill Addressbook
    Run Process  cmd.exe /c taskkill /F /IM AddressBook.exe  shell=True   

Suite Initialization 
    @{name}=  Split String  ${search_name}               
    Set Suite Variable    ${FIRST_NAME}  ${name}[0]      
    Set Suite Variable    ${LAST_NAME}  ${name}[1]       
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

