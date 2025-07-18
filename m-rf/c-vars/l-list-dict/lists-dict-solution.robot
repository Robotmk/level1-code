*** Settings ***
Library  Collections

*** Variables ***

# Create two lists with
# - 3 alcoholic drinks
# - 3 non-alcoholic drinks
@{ALC_DRINKS}           MaiTai    Caipirinha    GinTonic
@{NONALC_DRINKS}        Banana    Strawberry    Kiwi

# Create a dict with weekdays (Mon-Fri) as keys and a weather forecast 
# for each day
&{WEATHER_WEEKDAYS}
...                     Monday=sunny
...                     Tuesday=cloudy
...                     Wednesday=rainy
...                     Thursday=partly cloudy
...                     Friday=windy

*** Test Cases ***
Logging The Drinks
    # From both list variables, create a list which contains all drinks (6)
    VAR    @{all_drinks}    @{ALC_DRINKS}    @{NONALC_DRINKS}
    # Add Cola at the end of all_drinks (use a keyword from the Collections library)
    Append To List   ${all_drinks}    Cola
    Log    All Drinks:
    # Log all drinks
    Log Many    @{all_drinks}
    # Log the first of all drinks
    Log    ${all_drinks}[0]
    # Log the last of all drinks
    Log    ${all_drinks}[-1]

Logging The Weather
    # Create a dict with weekend days (Sat-Sun) and a weather forecast for each day
    VAR    &{weather_weekend}
    ...    Saturday=sunny
    ...    Sunday=stormy
    # Change the weather on sunday to snow
    ${weather_weekend}[Sunday]    Set Variable    snow
    # Create a weather dict for the whole week
    VAR    &{weather_week}    &{WEATHER_WEEKDAYS}    &{weather_weekend}
    # Log the weather on Tuesday
    Log  ${weather_week}[Tuesday]

