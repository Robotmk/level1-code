*** Variables ***
@{MONTIORING_SYSTEMS}       Naemon  Checkmk
@{MORE_MONTIORING_SYSTEMS}  Centreon  @{MONTIORING_SYSTEMS}  Nagios


*** Test Cases ***
A Static Test
    Log Many   Naemon  Checkmk

A Test With A List Variable
    Log Many    @{MONTIORING_SYSTEMS}

Extending A List Dynamically
    Log Many    @{MORE_MONTIORING_SYSTEMS} 
