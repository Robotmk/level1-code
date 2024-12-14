*** Variables ***
&{USER}    username=robotmk    password=secret123    role=admin
&{DATA}    user=${USER}    application=cmk  environment=dev

*** Test Cases ***
Use User Details
    Log To Console  Username is: ${USER}[username]
    Log To Console  Password is: ${USER}[password]
    Log To Console  Role is: ${USER}[role]

Access Nested Dictionary
    Log To Console  Role is: ${DATA}[user][role]