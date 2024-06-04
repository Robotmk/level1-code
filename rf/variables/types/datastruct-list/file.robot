*** Variables ***
@{LIBRARIES}    Requests  Selenium   Appium   Playwright  ImageHorizon

*** Test Cases ***
Display Libraries
    Log    The first library is: ${LIBRARIES[0]}
    Log    The second library is: ${LIBRARIES[1]}
    Log    The third library is: ${LIBRARIES[2]}
    Log    Last library: ${LIBRARIES[-1]}
    Log    All libs: @{LIBRARIES}