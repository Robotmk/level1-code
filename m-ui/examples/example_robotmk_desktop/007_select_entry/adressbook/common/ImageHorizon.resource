*** Settings ***
Library  ImageHorizonLibrary


*** Keywords ***
MoveClick
    [Documentation]  Moves the Mouse to a location and clicks the given button once
    [Arguments]      ${location}  ${button}=left
    ImageHorizonLibrary.Move To  ${location}
    ImageHorizonLibrary.Click  ${button}

MoveDoubleClick
    [Documentation]  Moves the Mouse to a location and double clicks the given button once
    [Arguments]      ${location}  ${button}=left
    ImageHorizonLibrary.Move To  ${location}
    ImageHorizonLibrary.Double Click  ${button}

Wait For And Click
    [Documentation]  Waits for the given image and clicks on it. Returns the location of the found image
    [Arguments]      ${reference_image}  ${timeout}=10
    #ImageHorizonLibrary.Wait For  ${reference_image}  ${timeout}
    #Sleep  1s            # Wait until content has loaded properly
    ${location}=  ImageHorizonLibrary.Wait For  ${reference_image}   ${timeout}
    MoveClick  ${location}
    [Return]   ${location}



Wait For And Double Click
    [Documentation]  Waits for the given image and double clicks on it. Returns the location of the found image
    [Arguments]      ${reference_image}  ${timeout}=10
    #ImageHorizonLibrary.Wait For  ${reference_image}  ${timeout}
    #Sleep  1s            # Wait until content has loaded properly
    ${location}=  ImageHorizonLibrary.Wait For  ${reference_image}  ${timeout}
    MoveDoubleClick  ${location}
    [Return]   ${location}