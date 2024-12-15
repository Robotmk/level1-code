*** Settings ***
Documentation       This suite opens the Keepass Demo database and searches for Robotmk entries.

Library             Process
Library             String
Library             ImageHorizonLibrary    reference_folder=${CURDIR}\\images
Library             common${/}WindowsUtils.py
Resource            common${/}ImageHorizon.resource

Test Setup          Open Keepass
Test Teardown  Kill KeePass

*** Variables ***
${KEEPASS_EXE_PATH}     C:${/}Program Files${/}KeePass Password Safe 2${/}KeePass.exe
${KEEPASS_EXE}          KeePass.exe
${KDBX_PATH}        ${CURDIR}${/}robotmk-db.kdbx


*** Test Cases ***
Search Database Entries
    Open Database  ${KDBX_PATH}
    Search Database Entry    robotmk


*** Keywords ***
Open KeePass
    [Documentation]    Opens the Keepass app
    Kill Keepass
    Launch Application    "${KEEPASS_EXE_PATH}"    alias=keepass
    Wait For    menu_bar
    #Run Keyword And Ignore Error    Wait For and Click  maximize


Open Database
    [Documentation]  Opens a kdbx file with the given path
    [Arguments]  ${path}
    Press Combination  Key.Ctrl  o
    Wait For    kdbx_open_dialog_title
    Press Combination  Key.ALT  n 
    Type  ${path}
    Press Combination  Key.ENTER
    Wait For   master_key_label
    Click To The Right Of Image    master_key_label    100
    Type  robotmk
    Type  Key.ENTER
    Wait For  kdbx_title.png


Kill KeePass
    [Documentation]    Kills the keepass process
    Run Process    cmd.exe /c taskkill /F /IM KeePass.exe    shell=True

Search Database Entry
    [Documentation]    Uses the given string to perform a search in the Keepass store.
    ...    The same name is also used for the image of the result.
    [Arguments]    ${seachstring}
    Press Combination  Key.CTRL  f 
    Type  robotmk 
    Press Combination  Key.ENTER 
    Wait For  two_entries_found 

