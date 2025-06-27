*** Settings ***
Library  Collections

*** Variables ***

# Create two lists with 
# - 3 alcoholic drinks
# - 3 non-alcoholic drinks
# (choose your favorites)
# => 

# Create a dict with weekdays (Mon-Fri) as keys 
# and a weather forecast for each day (choose your favorites)
# => 

*** Test Cases ***
Logging The Drinks
    # From both list variables, create a list which contains all drinks (6)
    # =>
    # Add Cola at the end of all_drinks (use a keyword from the Collections library)
    # =>
    # Log all drinks: use the "Log Many" keyword which accespt a list variable / multiple arguments
    Log    All Drinks:
    # =>
    # Log the first of all drinks
    # =>
    # Log the last of all drinks
    # =>

Logging The Weather
    # Create a dict with weekend days (Sat-Sun) and a weather forecast for each day
    # =>
    # Change the weather on sunday to snow
    # =>
    # Create a weather dict for the whole week
    # =>
    # Log the weather on Tuesday
    # =>
    No Operation

