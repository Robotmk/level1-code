*** Variables ***
@{LIBRARIES}    Selenium   Appium   Playwright
@{MORE_LIBRARIES}  DataDriver  @{LIBRARIES}  Requests

*** Test Cases ***
Logging The Lists
    Log Many    @{LIBRARIES}
    Log    All libs: @{LIBRARIES}
    Log Many    @{MORE_LIBRARIES} 

Logging List Items
    Log    The first library is: ${LIBRARIES}[0]
    Log    The second library is: ${LIBRARIES}[1]
    Log    The third library is: ${LIBRARIES}[2]
    Log    Last library: ${LIBRARIES}[-1]