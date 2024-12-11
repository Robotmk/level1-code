*** Settings ***
Documentation     Demonstrate the usage of the basic FOR loop.

*** Variables ***
@{fruit_basket}    apple  banana  cherry

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