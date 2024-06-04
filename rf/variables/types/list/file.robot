*** Test Cases ***
A Static Test
    Log    Naemon  Checkmk

A Test With A List Variable
    Log    @{MONTIORING_SYSTEMS}

Extending A List Dynamically
    Log    Centreon  @{MONTIORING_SYSTEMS}  Nagios
