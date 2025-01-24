*** Comments ***
# robocop: disable=missing-doc-suite
# robocop: disable=redundant-equal-sign


*** Settings ***
Resource    ../libraries/ImageHorizonLibrary.resource
Library     OperatingSystem
Library     ScreenCapLibrary
Library  String
#Resource  Common.resource

*** Variables ***
${IMAGES_ROOT}  ${ROOT_DIR}${/}images
${CONFIDENCE_LOW}       0.8


*** Keywords ***
Change Image Folder    # robocop: disable:too-few-calls-in-keyword
    [Documentation]    Sets the ImageHorizon reference folder to the given path.
    [Arguments]    ${path}
    ImageHorizonLibrary.Set Reference Folder    ${path}

Set App Image Folder    # robocop: disable:too-few-calls-in-keyword
    [Documentation]    Sets the ImageHorizon reference folder to the given path.
    [Arguments]    ${path}
    ${IMAGES_OLD_PATH}=    Get Variable Value    
    ...    ${IMAGES_APP_PATH}    
    ...    ${IMAGES_ROOT}${/}${path}
    Set Suite Variable    ${IMAGES_APP_PATH}   ${IMAGES_ROOT}${/}${path}
    ImageHorizonLibrary.Set Reference Folder    ${IMAGES_APP_PATH}

Reset App Image Folder    # robocop: disable:too-few-calls-in-keyword
    [Documentation]    Resets the Image refernce paht to the default
    ImageHorizonLibrary.Set Reference Folder    ${IMAGES_ROOT}

MoveClick
    [Documentation]    Moves the Mouse to a location and clicks the given button once
    [Arguments]    ${location}    ${button}=left
    ImageHorizonLibrary.Move To    ${location}
    ImageHorizonLibrary.Click    ${button}

MoveDoubleClick
    [Documentation]    Moves the Mouse to a location and double clicks the given button once
    [Arguments]    ${location}    ${button}=left
    ImageHorizonLibrary.Move To    ${location}
    ImageHorizonLibrary.Double Click    ${button}

Click Image If Exists
    [Documentation]
    ...    Clicks the given reference image if it exists. Returns ``True`` if
    ...    reference image was found on screen or ``False``    otherwise
    [Arguments]    ${reference_image}
    ${exists}=    ImageHorizonLibrary.Does Exist    ${reference_image}
    IF    '${exists}' == '${True}'
        ImageHorizonLibrary.Click Image    ${reference_image}
    END
    RETURN    ${exists}


Move Mouse To Image
    [Documentation]
    ...    Moves the mouse pointer to the reference image.
    [Arguments]    ${reference_image}    ${timeout}=10
    ${location}=    ImageHorizonLibrary.Wait For    ${reference_image}    ${timeout}
    ImageHorizonLibrary.Move To    ${location}

Move Relative To
    [Documentation]
    ...    Moves the mouse cursor relatively to the given location by the given offset values.
    [Arguments]    ${location}    ${xOffsett}    ${yOffsett}
    ${xPos}=    Evaluate    ${location}[0] + ${xOffsett}
    ${yPos}=    Evaluate    ${location}[1] + ${yOffsett}
    Move To    ${xPos}    ${yPos}

Wait For And Click
    [Documentation]    Waits for the given image and clicks on it. Returns the location of the found image
    [Arguments]    ${reference_image}    ${timeout}=10
    ${location}=    ImageHorizonLibrary.Wait For    ${reference_image}  ${timeout}
    MoveClick    ${location}
    RETURN    ${location}

Wait For And Double Click
    [Documentation]    Waits for the given image and double clicks on it. Returns the location of the found image
    [Arguments]    ${reference_image}    ${timeout}=10
    ImageHorizonLibrary.Wait For    ${reference_image}    ${timeout}
    ${location}=    ImageHorizonLibrary.Wait For    ${reference_image}    ${timeout}
    MoveDoubleClick    ${location}
    RETURN    ${location}

Wait For And Context Click
    [Documentation]
    ...    Waits for the given image and context-clicks (right mouse mutton) on it. Returns
    ...    the location of the found image.
    [Arguments]    ${reference_image}    ${timeout}=10
    ImageHorizonLibrary.Wait For    ${reference_image}    ${timeout}
    ${location}=    ImageHorizonLibrary.Wait For    ${reference_image}    ${timeout}
    MoveClick    ${location}    button=right
    RETURN    ${location}

Wait For And Click And Move Away
    [Documentation]    Waits for the given image, clicks on it and moving away from it 50px in x- and y-direction.
    [Arguments]    ${reference_image}    ${timeout}=10
    ${location}=    Wait For And Click    ${reference_image}    ${timeout}
    Move Relative To    ${location}    50    50
    RETURN    ${location}

Should Not Exist
    [Documentation]    Returns whether the given image exists.
    ...  If no timeout is given, the image must be found immediately.
    [Arguments]    ${reference_image}  ${timeout}=0
    IF    ${timeout} == "0"
        ${exists}=    ImageHorizonLibrary.Does Exist    ${reference_image}
    ELSE
        ${exists}=    Run Keyword And Return Status
        ...    ImageHorizonLibrary.Wait For    ${reference_image}    ${timeout}
    END
    
    # SME: commented out, senseless
    #IF    '${exist}'=='${true}'    Take Screenshot
    #Should Not Be True    ${exist}    msg=The given image ${reference_image} should not exist, but it does.
    RETURN  ${exists}

Wait For And Input Text RightOf
    [Documentation]
    ...    Wait for an image    with Input field on the right hand side, click using the given offset and
    ...    enters the given text
    [Arguments]    ${reference_image}    ${offset}    @{text}    ${timeout}=10
    ImageHorizonLibrary.Wait For    ${reference_image}    ${timeout}
    ${location}=    ImageHorizonLibrary.Wait For    ${reference_image}    ${timeout}
    ImageHorizonLibrary.Click To The Right Of    ${location}    ${offset}
    ImageHorizonLibrary.Type    @{text}

Handle Message Dialog
    [Documentation]
    ...    Waits for the given ``dialog_reference_image`` which is used to identify the dialog and
    ...    clicks to the given confirmation button image ``confirmButton_reference_image`` to close the
    ...    the dialog (typically a OK- or Cancel-button).
    ...    If "${fail_with_message}" is set, the keyword fails with that message.
    [Arguments]    
    ...    ${dialog_reference_image}    
    ...    ${confirmButton_reference_image}    
    ...    ${fail_with_message}=${False}
    ...    ${timeout}=10
    ${exists}=  ImageHorizon.Should Not Exist    ${dialog_reference_image}    ${timeout}
    IF   ${exists}
        Common.Take A Screenshot
        ImageHorizonLibrary.Click Image    ${confirmButton_reference_image}
        IF   "${fail_with_message}" != "${False}"
            Fail   ${fail_with_message}
        END
    END
    
Handle Subsequent Dialogs
    [Documentation]
    ...    Wrapper for "Handle Message Dialog". Useful if after the first error 
    ...    message, other ones are probably following. 
    ...    Thus, the timeout1 is used only for the first error; subsequent error 
    ...    messages are handled with a shortert timeout2.
    ...    "${dialog_images}" and "${dialog_handle_images}" must be folders
    ...    where IHL will automatically search for possible matches.
    ...    Other than "Handle Message Dialog", this keyword will never fail. 
    ...    Instead, it will try max. 100 times to click aways error messages.
    [Arguments]    
    ...    ${dialog_images}    
    ...    ${dialog_handle_images}    
    ...    ${fail_with_message}=${False}
    ...    ${timeout1}=10
    ...    ${timeout2}=1
    Log  Waiting for the first dialogue...
    # Choose timeout so that the first error will definitely appear within 
    # this time. 
    Handle Message Dialog  
    ...  ${dialog_images}    ${dialog_handle_images}    
    ...  fail_with_message=${fail_with_message}
    ...  timeout=${timeout1}
    
    Builtin.Wait Until Keyword Succeeds    100x    1s  
    ...  Handle Message Dialog  
    ...  ${dialog_images}    ${dialog_handle_images}    
    ...  fail_with_message=${fail_with_message}
    ...  timeout=${timeout2}
  


React on Multiple Images
    [Documentation]
    ...  Use this for "if A then B elif C then D" situations.
    ...  - place screenshots of all ref_images to react on into a common folder = $ref_image_path 
    ...  - also place each ref_image into the root image path 
    ...  - for those ref_images which RF should react on, place an action image into the root image path = ${ref_image}_action
    [Arguments]  ${ref_image_path}  @{ref_images}  ${timeout}=10  
    ${exists}=  Run Keyword And Return Status  Wait For  ${ref_image_path}  ${timeout}
    # We know that one of the ref_images exists. Let's find out which one.
    IF  ${exists}
        FOR    ${image}    IN    @{ref_images}
            ${exists2}=  Does Exist  ${image}
            IF  ${exists2}  
                # Ensure Focus is there
                Click Image  ${image}
                BREAK
            END
            # now the image is known which we can react on; exit the loop
        END
        ${action_image}=  Set variable  ${image}_action
        # This matches a single image (including extension) and a folder containing
        # multiple images
        ${do_action}=  Run Keyword And Return Status  
        ...  Should Exist    ${IMAGES_ROOT}\\${action_image}*
        IF  ${do_action}
            Click Image  ${action_image}
        END
        
    ELSE 
        Fail  msg=None of the given images to react on seems to exist!
    END

    ImageHorizonLibrary.Wait For  ${ref_image_path}  ${timeout}

React On Image
    [Documentation]
    ...  Waits for the given ``ref_image`` and reacts with ``action_image``.
    ...  If ``action_image`` is None, do nothing.
    ...  If ``timeout`` is given, wait for the image; otherwise locate it (=must be present)
    [Arguments]  ${ref_image}  ${action_image}=${None}  ${timeout}=${None}
    IF  '${timeout}'
        ${exists}=  Run Keyword And Return Status  Wait For  ${ref_image}  ${timeout}
    ELSE
        ${exists}=  Run Keyword And Return Status  Wait For  ${ref_image}  ${timeout}
    END
    IF  '${exists}'
        Run Keyword If  '${action_image}'  Wait For And Click  ${action_image}
    END


Select From Dropdown
    [Documentation]
    ...    Selects the given ``item_selection`` from the dropdown which is identified by the
    ...    ``label_reference_image`` if it is not yet selected.
    ...
    ...    ``label_reference_image`` is an image (usually the label) which identifies the dropdown field.
    ...
    ...    ``item_selection`` is the item that is going to be selected.
    ...
    ...    ``offset`` is an offset in pixels in the direction ``offsetDirection`` relative to the
    ...    given ``label_reference_image`` where the dropdown field is going to be found.
    ...
    ...    ``offsetDirection`` is the direction relative to the ``label_reference_image`` where the dropdown
    ...    field is going to be found. Valid directions are ``Right``, ``Left``, ``Above`` or ``Below``.
    [Arguments]    ${label_reference_image}    ${item_selection}    ${offset}    ${offsetDirection}=Right
    ${exists}=    ImageHorizonLibrary.Does Exist    ${item_selection}
    IF    '${exists}' == '${True}'    RETURN

    Run Keyword    Click To The ${offsetDirection} Of Image    ${label_reference_image}    ${offset}
    Wait For And Click    ${item_selection}

# Localized actions
# If the SUT should be tested with different display languages, chances are that
# the images are not matching anymore.

# 'FR': {    # Canton
#    ...
#    'loc_img': [    # Set as variable in suite scope (@{kanton_loc_img})
#    'aae_zeile_markiert',    # list of image names which are language specific
#    ]
#    },

LWait For
    [Documentation]
    ...    "localized wait". Relies on two variables set on suite scope:
    ...    - @{kanton_loc_img} - dict key "loc_img" (see above)
    ...    - ${KANTON_UC} - name of Canton
    ...    If the image name is found within the list, then the image search path gets
    ...    bent to the canton subfolder where the correct image can be found.
    ...    After that the seafrch path gets resetted.
    [Arguments]    ${image}    ${timeout}
    IF    '${image}' in ${kanton_loc_img}
        Change Image Folder    ${imgpath}\\${KANTON_UC}
    END
    ${loc}=    ImageHorizonLibrary.Wait For    ${image}    ${timeout}
    IF    '${image}' in ${kanton_loc_img}    Change Image Folder    ${imgpath}
    RETURN    ${loc}

LWait For And Input Text RightOf
    [Documentation]
    ...    "localized" Wait for an image (see LWait for) with Input field on the right hand side,
    ...    click using the given offset and enters the given text
    [Arguments]    ${image}    ${timeout}    ${offset}    @{text}
    ${location}=    LWait For    ${image}    ${timeout}
    ImageHorizonLibrary.Click To The Right Of    ${location}    ${offset}
    ImageHorizonLibrary.Type    @{text}

LWait For And Click
    [Documentation]    "localized" Wait for (see LWait for) and clicks on it. Retruns the location of the found image
    [Arguments]    ${image}    ${timeout}=10
    ${location}=    LWait For    ${image}    ${timeout}
    MoveClick    ${location}
    RETURN    ${location}

Wait For Variants In Region And Record Unknown
    [Documentation]    Iterates over variants of the given file and returns OK if found.
    ...    If not found, the region where the image was expected gets recorded and saved
    ...    with a md5 hash within the filename in a subfolder unknown_variants/.
    ...    When reviewing the test, new variants of the appeared image can be moved into the images/ folder.
    [Arguments]    ${image}    ${timeout}=10    ${path}=images    ${left}=0    ${top}=0    ${width}=100    ${height}=100
    # timeout = per image variant!
    # left/top/width/height = coordinates/dimensions of region to record in case nothing was found.
    @{VARIANTS}=    List Files In Directory    ${path}    ${image}_var_*
    ImageHorizonLibrary.Set Confidence    ${CONFIDENCE_LOW}
    #ImageHorizonLibrary.Set Confidence    1
    FOR    ${variant}    IN    @{VARIANTS}
        Log    Suche Bildvariante ${variant} ...
        ${FOUND}=    Run Keyword And Return Status    ImageHorizonLibrary.Wait For    ${variant}    timeout=${timeout}
        IF    ${FOUND}
            Log    Bild gefunden (${variant})!
            RETURN
        END
    END
    Log    Keine Variante für Bild ${image} gefunden; erstelle neue...
    ${unknown_variants_dir}=    Set Variable    ${path}/unknown_variants
    Create Directory    ${unknown_variants_dir}
    ${unknown_variant_file}=    ScreenCapLibrary.Take Partial Screenshot
    ...    left=${left}    top=${top}    width=${width}    height=${height}
    ...    name=${unknown_variants_dir}/${image}_var    embed=False
    ${md5}=    Get File Md5sum    ${unknown_variant_file}
    Move File    ${unknown_variant_file}    ${unknown_variants_dir}/${image}_var_${md5}.png
    ImageHorizonLibrary.Set Confidence    1
    Fail
    ...    msg=Keine Bildvariante für ${image} gefunden, neue gespeichert: ${unknown_variants_dir}/${image}_var_${md5}.png

Navigate In Treeview 
    [Documentation]    "localized" Wait for (see LWait for) and clicks on it. Retruns the location of the found image
    [Arguments]    ${nodes}  ${prefix}=${EMPTY}   ${separator}=_
    ${nodestring}    Evaluate  " > ".join(@{nodes})
    Log  Navigating in Tree: ${nodestring}
    FOR  ${node}  IN  @{nodes}
        ${imagename}  Set Variable  ${prefix}${separator}${node}
        Wait For And Double Click  ${imagename}
        ${prefix}  Set Variable  ${imagename}
    END
