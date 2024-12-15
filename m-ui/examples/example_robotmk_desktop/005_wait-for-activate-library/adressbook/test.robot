# Another inpredictable thing is the size of the app window. Don't rely on this! 
# The Python file "WindowUtils.py" is a small library which contains useful keywords to 
# activate and maximize a Window just by its window title. 

# When the window was maximized at the end of keyword "Open Address Book", we should 
# check if the application window is really visible. (This is called an "assertion".)
# "ab_logo" is a screenshot of the app log in the upper left corner and the argument for 
# keyword "Wait For".

##### 
# Your tasks: 
# - Set a breakpoint in WindowUtils.py and debug into the Python code to see how the 
#   keyword works. 

*** Settings ***
Documentation     This suite opens the "Free Address Book" and searches for a given user. 
...  The user can be given by variable `SEARCH_NAME` (first + last name).
Library       ImageHorizonLibrary  reference_folder=${CURDIR}\\images   
Library       Process   
Library       common\\WindowsUtils.py   # ⚠️   
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
    Run Process  cmd.exe /c taskkill /F /IM AddressBook.exe  shell=True   

Suite Initialization    
    Open Address Book    

Suite Finalization     
    Close Address Book   

Open Address Book 
    Kill Addressbook    
    Launch Application    "${APP}"  alias=addressbook   
    Wait For Window And Activate    .*Free Address Book  maximize=True   # ⚠️ 
    Wait For          ab_logo         # ⚠️ 

Close Address Book 
    Terminate Application  alias=addressbook      

