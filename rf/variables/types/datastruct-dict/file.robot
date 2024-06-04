*** Variables ***
&{USER}    username=robotmk    password=secret123    role=admin

*** Test Cases ***
Use User Details
    Log    Username is: ${USER}[username]
    Log    Password is: ${USER}[password]
    Log    Role is: ${USER}[role]
