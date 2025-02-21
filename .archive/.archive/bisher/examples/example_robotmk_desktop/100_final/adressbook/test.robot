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
    Wait For And Double Click    ${FIRST_NAME}_marked
    ${found}=  Run Keyword And Return Status                    
    ...  Wait For  ${FIRST_NAME}_${LAST_NAME}_details                   
    IF  not ${found}                                            
        Fail  msg=No entry found for ${SEARCH_NAME}!            
    END                                                         

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

