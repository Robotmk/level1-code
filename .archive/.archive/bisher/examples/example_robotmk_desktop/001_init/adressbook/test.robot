# Welcome to this Robot Framework test! Our goal is to write a UI test which 
# as described in the Doc string. From that, we have scaffolded a suite file: 
# - In Settings, we import the ImageHorizonLibrary
# - In Test Cases, we created one test case, but still empty. RF does not allow
#   to have emtpy tests, we use the keyword "No Operation" from the Builtin library. 
#   It does, right: nothing - but prevents an error message.  


*** Settings ***
Documentation     This suite opens the "Free Address Book" and searches for a given user. 
...  The user can be given by variable `SEARCH_NAME` (first + last name).
Library  ImageHorizonLibrary     # ⚠️ 

*** Test Cases ***
Search User In Database 
    No Operation    # ⚠️ 