*** Settings ***
Documentation  This resource file contains keywords to enhance the 
...    functionality of the ImageHorizonLibrary
Resource  lib-IHL.resource

*** Keywords ***

#    ___   _   _        _   
#   / __| | | (_)  __  | |__
#  | (__  | | | | / _| | / /
#   \___| |_| |_| \__| |_\_\
          
MoveClick
    [Documentation]    Moves the Mouse to a location and clicks the given button once
    [Arguments]    ${location}    ${button}=left
    ImageHorizonLibrary.Move To    ${location}
    ImageHorizonLibrary.Click    ${button}

Wait For And Click
    [Documentation]    Waits for the given image and clicks on it. Returns the location of the found image
    [Arguments]    ${reference_image}    ${button}=left    ${timeout}=10  
    ${location}=    ImageHorizonLibrary.Wait For    ${reference_image}  ${timeout}
    MoveClick    ${location}  ${button}
    RETURN    ${location}
               
Wait For And Click To The Above Of
    [Documentation]
    ...    Waits for the given image and clicks on the postion, which is the center postion of the image
    ...    moved in Y-direction by the given offset.
    [Arguments]    ${reference_image}    ${offset}    ${button}=left    ${timeout}=10    ${clicks}=1
    ${location}=    ImageHorizonLibrary.Wait For    ${reference_image}    ${timeout}
    ImageHorizonLibrary.Click To The Above Of    ${location}    ${offset}    ${clicks}    ${button}

Wait For And Click To The Below Of
    [Documentation]
    ...    Waits for the given image and clicks on the postion, which is the center postion of the image
    ...    moved in Y-direction by the given offset.
    [Arguments]    ${reference_image}    ${offset}    ${button}=left    ${timeout}=10    ${clicks}=1
    ${location}=    ImageHorizonLibrary.Wait For    ${reference_image}    ${timeout}
    ImageHorizonLibrary.Click To The Below Of    ${location}    ${offset}    ${clicks}    ${button}

Wait For And Click To The Right Of
    [Documentation]
    ...    Waits for the given image and clicks on the postion, which is the center postion of the image
    ...    moved in X-direction by the given offset.
    [Arguments]    ${reference_image}    ${offset}    ${button}=left    ${timeout}=10    ${clicks}=1
    ${location}=    ImageHorizonLibrary.Wait For    ${reference_image}    ${timeout}
    ImageHorizonLibrary.Click To The Right Of    ${location}    ${offset}    ${clicks}    ${button}

Wait For And Click To The Left Of
    [Documentation]
    ...    Waits for the given image and clicks on the postion, which is the center postion of the image
    ...    moved in negative X-direction by the given offset.
    [Arguments]    ${reference_image}    ${offset}    ${button}=left    ${timeout}=10    ${clicks}=1
    ${location}=    ImageHorizonLibrary.Wait For    ${reference_image}    ${timeout}
    ImageHorizonLibrary.Click To The Left Of    ${location}    ${offset}    ${clicks}    ${button}
