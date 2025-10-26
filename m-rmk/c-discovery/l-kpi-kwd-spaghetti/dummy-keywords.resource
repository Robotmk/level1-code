*** Keywords ***

# Dummy implementations of Library keywords;
# In real world, these would be written in Python. 

Fill Text
    [Arguments]    ${field}    ${text}
    Log  Filling text '${text}' into field '${field}'

Click 
    [Arguments]    ${element}
    Log  Clicking button '${element}'

Wait Until Element Is Visible
    [Arguments]    ${element}
    Log  Waiting until element '${element}' is visible

