*** Settings ***
Documentation  This resource file contains keywords to enhance the 
...    functionality of the ImageHorizonLibrary


*** Keywords ***

MoveClick
    [Documentation]    Moves the Mouse to a location and clicks the given button once
    [Arguments]    ${location}    ${button}=left
    ImageHorizonLibrary.Move To    ${location}
    ImageHorizonLibrary.Click    ${button}

# WAIT / CLICK

Wait For And Click
    [Documentation]    Waits for the given image and clicks on it. Returns the location of the found image
    [Arguments]    ${reference_image}    ${timeout}=10
    ${location}=    ImageHorizonLibrary.Wait For    ${reference_image}  ${timeout}
    MoveClick    ${location}
    RETURN    ${location}
