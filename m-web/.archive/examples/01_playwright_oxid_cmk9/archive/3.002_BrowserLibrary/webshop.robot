*** Comments ***
-> Make Browser Library working. 

Key Learnings: 
- import Browser library
- Library Documentation
- Browser, Context, Page concept

This checkpoint contains all changes so that the browser opens the shop URL.

!! ACTION: 
- Open Browser library documentation (see link above)
- Change locale to en-EN - how does the page look like? 

*** Settings ***   
Documentation       Oxid eshop test for login and item search.  

Library             Browser    #    <--HERE--    must be installed (see requirements.txt). https://marketsquare.github.io/robotframework-browser/Browser.html


*** Variables ***    #  <--HERE--  Variables defined here have Suite scope. Use UPPERCASE
${URL}          https://oxid.robotmk.org     #  <--HERE--  URL for the Application under test (AUT)
${BROWSER}      chromium    # <--HERE-- also possible: firefox, webkit


*** Test Cases ***
Login with valid credentials
    [Documentation]    A user with valid credentials must be able to login.    
    #  <--HERE--  https://marketsquare.github.io/robotframework-browser/Browser.html#New%20Context
    # Start a new browser (=process)
    New Browser    browser=${BROWSER}    headless=False
    
    # Create a new context (~"identity")
    # A viewport of None leads to a browser window with optimal width and maximal height
    # If the page is i18n, setting the context locale can result in the desired page language.
    New Context    viewport=${None}    locale=de-DE
    # New Context    viewport=${None}    locale=en-EN
    
    # Create a new page (~"tab" within identity)
    New Page    ${URL}
    
    # Conveniance wrapper (use only for testing): 
    # Open Browser = 
	#   	- New Browser 
	#   	- New Context 
	#   	- New Page
    #Open Browser    ${URL}    ${browser}    headless=False


    No Operation   #  !!ACTION: Set a breakpoint in this line (F9) and start the debugger (click on 
    # "Debug" in the Code lens on top of the test name or press F5).
    # The browser should show the web shop's landing page. 
    #  !!ACTION: Have a look on the variable inspector in the upper left corner!
    # Press Shift-F5 to stop the debugger, it will kill also the browser process. 


Login with invalid credentials
    [Documentation]    A user with valid credentials must be able to login.   
    No Operation

Search Item And Add To Basket
    [Documentation]    Searches an article, adds it to the basket and tries to navigate to the checkout page.
    No Operation
