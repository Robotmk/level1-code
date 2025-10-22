*** Variables *** 
${A}  3
${B}  4

*** Test Cases ***
Evaluating Simple Python Expressions
    ${finger_count}=  Evaluate  5 + 5  # Addition with variables
    ${week}=  Evaluate  ${A} + ${B}  # Addition with variables
    ${equal}=  Evaluate  ${A} != ${B}  # Comparison
    ${greater}=    Evaluate    ${B} < ${A}
    Run Keyword If    ${greater}    Fail   msg=B is greater than A!

Advanced Python Expressions
    # Doubling values in a list comprehension
    ${items}=  Evaluate    [i * 2 for i in range(5)]
    # Determining a random integer within a range
    ${random} =	Evaluate	random.randint(0, sys.maxsize)
    # Compact ternary Python expression
    ${result}=    Evaluate    "higher" if 5 > 3 else "lower"
    # math operation with the math module
    ${pi}=  Evaluate    round(math.pi, 3)    modules=math