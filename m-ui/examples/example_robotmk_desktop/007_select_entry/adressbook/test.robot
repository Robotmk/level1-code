# Now the entry we want to open must be selected from the search results. 
# 
# We have added one second sleep time to make sure that the search has finished. 
#
# The adressbook ap is a little bit picky: doubleclicking an entry which is not selected 
# does not work reliable!
# To do the "click", we have taken a screenshot of the _inactive_ region of the LAST_NAME 
# of the person. 
# Unfortunately, this click also triggers a "hover" effect which shows a hint flag at the 
# mouse position. This makes the detection of the entry unreliable/impossible. 
# The "Solution" is here to search for and click on another part of the marked line. We 
# have made a screenshot of the marked FIRST name and saved it under ${FIRST_NAME}_marked.

##### 
# Your tasks: 
# - run the test. 
# - The test should open now the Person's entry. 

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
    Sleep  1   # ⚠️    
    Wait For And Click  ${LAST_NAME}                   # ⚠️
    # Set a breakpoint here 
    Wait For And Double Click    ${FIRST_NAME}_marked  # ⚠️  
    
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

