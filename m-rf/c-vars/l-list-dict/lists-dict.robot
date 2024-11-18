*** Variables ***
@{LIBRARIES}    Selenium   Appium   Playwright
@{MORE_LIBRARIES}  DataDriver  @{LIBRARIES}  Requests
&{USER_DATA}         name=robotmk    password=secret
&{MORE_USER_DATA}    role=admin  &{USER_DATA}  status=active

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

Logging The Dicts
    Log Many    &{USER_DATA}
    Log  All User Data: &{USER_DATA}
    Log Many    &{MORE_USER_DATA}

Logging Dict Items
    Log    The name is: ${USER_DATA}[name]
    Log    The password is: ${USER_DATA}[password]
    Log    The name is: ${MORE_USER_DATA}[name]
    Log    The password is: ${MORE_USER_DATA}[password]
    Log    The role is: ${MORE_USER_DATA}[role]
    Log    The status is: ${MORE_USER_DATA}[status]

Logging Dict Items - Dot Notation
    Log    The name is: ${USER_DATA.name}
    Log    The password is: ${USER_DATA.password}
    Log    The name is: ${MORE_USER_DATA.name}
    Log    The password is: ${MORE_USER_DATA.password}    
    Log    The role is: ${MORE_USER_DATA.role}
    Log    The status is: ${MORE_USER_DATA.status}