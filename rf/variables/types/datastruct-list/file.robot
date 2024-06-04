*** Variables ***
@{LIBRARIES}    Requests  Selenium   Appium   Playwright  ImageHorizon

*** Test Cases ***
Display Libraries
    Log To Console    The first library is: ${LIBRARIES[0]}
    Log To Console    The second library is: ${LIBRARIES[1]}
    Log To Console    The third library is: ${LIBRARIES[2]}
    Log To Console    Last library: ${LIBRARIES[-1]}
    Log To Console    All libs: @{LIBRARIES}