*** Variables ***
&{USER_DATA}         name=robotmk    password=secret
&{MORE_USER_DATA}    role=admin  &{USER_DATA}  status=active

*** Test Cases ***
Logging The Dicts
    Log Many    &{USER_DATA}
    Log  All User Data: &{USER_DATA}
    Log Many    &{MORE_USER_DATA}

Logging Dict Items
    Log    The name is: ${USER_DATA}[name]
    Log    The password is: ${USER_DATA}[password]
    Log    The role is: ${MORE_USER_DATA}[role]
    Log    The status is: ${MORE_USER_DATA}[status]
    Log    The name is: ${MORE_USER_DATA}[name]
    Log    The password is: ${MORE_USER_DATA}[password]

Logging Dict Items - Dot Notation
    Log    The name is: ${USER_DATA.name}
    Log    The password is: ${USER_DATA.password}
    Log    The role is: ${MORE_USER_DATA.role}
    Log    The status is: ${MORE_USER_DATA.status}
    Log    The name is: ${MORE_USER_DATA.name}
    Log    The password is: ${MORE_USER_DATA.password}