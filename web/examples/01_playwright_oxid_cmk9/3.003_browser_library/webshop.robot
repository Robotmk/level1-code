*** Comments ***
Objective: Import Browser Library

Key Learnings:
- requirements.txt
- Importing libraries
- Using keywords from imported libraries
- Suite variables BROWSER/URL and where they come from
- Browser, Context, Page concept
- available browsers
- using the VS Code debugger
- setting the browser "viewport" parameter
- using the browser "locale" parameter

!! ACTION:
- Become familar with the Browser library documentation
- Set a breakpoint in the line with "BREAK" and start the debugger. Pay attention to the variables.
- Change locale to en-EN - how does the page look like?


*** Settings ***
Documentation       This suite contains tests to verify that login
...                 and basic basket/ordering functionality is working.

Resource            webshop_oxid.resource
Library             Browser    #    <--HERE--    must be installed (see requirements.txt).


*** Variables ***
${BROWSER}      chromium    # <--HERE-- also possible: firefox, webkit


*** Test Cases ***
Login with valid credentials
    [Documentation]    The purpose of this test case is to verify that a user can successfully log
    ...    in to the application using valid credentials.
    # Start a new browser... (=process)
    New Browser    browser=${BROWSER}    headless=False

    # ...create a new context (~"identity")
    # A viewport of "None" leads to a browser window with optimal width and maximal height
    # If the page is multi-lingual, setting the context locale can result in the desired page language.
    New Context    viewport=${None}    locale=de-DE

    # ...and open a new page (~"tab" within identity)
    New Page    ${URL}

    # Conveniance wrapper (use only for testing):
    # Open Browser =
    #    - New Browser
    #    - New Context
    #    - New Page
    # Open Browser    ${URL}    ${browser}    headless=False

      
    No Operation    # BREAKPOINT: use the debugger to inspect the page

Login with invalid credentials
    [Documentation]    The purpose of this test case is to verify that a user with invalid credentials
    ...    cannot log into the shop system.
    No Operation

Search Item And Add To Basket
    [Documentation]    The purpose of this test case is to verify that a user can search for an item,
    ...    add it into the basket and get an expected total price.
    No Operation
