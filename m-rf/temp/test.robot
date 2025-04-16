*** Settings ***
Library  Collections

*** Test Cases ***
Test List Variables
    @{fruits}       Get Fruits   # using @-notation
    Log  ${fruits}[1]
    ${fruits}       Get Fruits   # same, using $-notation
    Log  ${fruits}[1]

Test Dict Variables
    &{cars}       Get Cars  # using &-notation
    Log  ${cars}[ford]        # - bracket-access
    Log  ${cars.ford}         # - dot-access
    &{cars}       Get Cars  # using the $-notation
    Log  ${cars}[ford]

*** Keywords *** 
Get Fruits
    RETURN  apple  banana  cherry


Get Cars
    # THIS IS WRONG! It does not return a dictionary!
    # RETURN  ford=mustang  alfa=romeo  bmw=e30
    &{mycars}=  Create Dictionary  ford=mustang  alfa=romeo  bmw=e30
    RETURN  &{mycars}
   