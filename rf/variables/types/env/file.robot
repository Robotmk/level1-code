*** Test Cases ***
A Static Test
    Store Data   C:\Users\simon_meggle\AppData\

A Test With A Env Variable
    Store Data   %{USERPROFILE}

A Test With A Env Variable And A Default Value
    Store Data   %{USERPROFILE=C:\TEMP}

    