*** Settings ***
Documentation     Demonstrate the usage of the basic FOR loop.

*** Variables ***
@{fruit_basket}    apple  banana  cherry
${fruit1}          strawberry
${fruit2}          orange

*** Test Cases ***
Example FOR single fruits
    Log    Logging three fruits...
    FOR    ${fruit}    IN    apple  banana  cherry
        Log    ${fruit}
    END
    Log    That's all folks!

Example FOR fruit basket
    Log    Logging fruits from a basket...
    FOR    ${fruit}    IN    @{fruit_basket}
        Log    ${fruit}
    END
    Log    That's all from the basket!

Example FOR fruit basket with variable
    Log    Logging fruits from a basket with bonus fruits...
    FOR    ${fruit}    IN    ${fruit_basket}    ${fruit1}    ${fruit2}
        Log To Console    ${fruit}
    END
    Log    That was a lot!