*** Settings ***
Library   ImageHorizonLibrary  reference_folder=${CURDIR}/images

*** Test Cases ***

Test One
    Wait For And Click    win
    No Operation    


*** Keywords ***

Wait For And Click
    [Documentation]    Waits for the given image and clicks on it. Returns the location of the found image
    [Arguments]    ${reference_image}    ${timeout}=10
    ${location}=    ImageHorizonLibrary.Wait For    ${reference_image}  ${timeout}
    MoveClick    ${location}
    RETURN    ${location}

MoveClick
    [Documentation]    Moves the Mouse to a location and clicks the given button once
    [Arguments]    ${location}    ${button}=left
    ImageHorizonLibrary.Move To    ${location}
    ImageHorizonLibrary.Click    ${button}
