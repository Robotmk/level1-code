*** Settings ***
Library     Browser

*** Test Cases ***
Select First Option
    New Browser    headless=False
    New Context    locale=en-US
    New Page    url=https://the-internet.herokuapp.com/dropdown
    Select Options By  select\#dropdown  value  1
    Sleep  1
    ${selected}=  Get Selected Options  select\#dropdown
    Log  These options are selected: ${selected}
    Log  Clearing now... 
    Deselect Options  select\#dropdown
    ${selected}=  Get Selected Options  select\#dropdown
    Log  These options are selected: ${selected}
    Sleep  2
