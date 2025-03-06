*** Settings ***
Documentation  This resource file contains helper keywords which can be used in arbitrary 
...  test scenarios, independent from the libraries used. 
# Import the Library instance from an external resource to avoid redundant imports.
Resource  lib-ScreenCap.resource

*** Keywords ***

Take Screenshot
    [Documentation]  Use this keyword to take a screenshot and embed it into the 
    ...  log.html file. Default format is PNG. 
    ...  By default, the screenshot is not saved on disk to save disk space.
    ...  If local storage is needed, an underscore, a running index and an extension
    ...  gets appened to the name.
    [Arguments]  ${save_to_disk}=False  ${name}=${SUITE_NAME}_screenshot
    ScreenCapLibrary.Take Screenshot  
    ...    save_to_disk=${save_to_disk}  
    ...    name=${name}