*** Variables ***
@{MONTIORING_SYSTEMS}       Naemon  Checkmk
@{MORE_MONTIORING_SYSTEMS}  Centreon  @{MONTIORING_SYSTEMS}  Nagios


*** Test Cases ***
A Test With A List Variable
    Log    @{MONTIORING_SYSTEMS}

Extending A List Dynamically
    Log    @{MORE_MONTIORING_SYSTEMS} 
